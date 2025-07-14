Return-Path: <linux-kernel+bounces-729708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573AB03A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEAA3BE506
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670CC244EA1;
	Mon, 14 Jul 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vANEBRxs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397324061F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484592; cv=none; b=NPIW6A0TA9/c1Uu+oUIzC8M4H/X/LKDETQoeWvFetHET0u2rg8ufc+PnI7FBjqMiSJ3+Kv9p6DuBDX/CstyJ7U9rqoLJOzSfOy07b1Br7wPDAhYKpoq6OV3wKzqLQFg6t2T/6iaDB/DA/MVfG01BvcyzRsp50HNicSFxKv+3b8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484592; c=relaxed/simple;
	bh=dv2xzXC+6TJZt9TJ3U/97Y9njM2Cu8lc2Jl+hxwFXTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qN4SwslIjiZ1tR2eAYWcQGGrGQ4oTRcQmuSS1up4vGS8gbG5rW96Tpmcgt4bDAcQtiFNh/+SvC9ZGOGAv0iByLYKoDTgKoYVz7wo2+GbF6UJ39QodYrxuuEyfBael8AsRGnNzAnM99n9gmh1gPJXadRSt7SuS2toj4RZOmEuA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vANEBRxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0473C4AF0D;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=dv2xzXC+6TJZt9TJ3U/97Y9njM2Cu8lc2Jl+hxwFXTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vANEBRxso8AO+F3t9PmhLE9ASwUpc8aPCXwvHEmYXUXIdRJzu9UuewMglEEzxzgda
	 NniBKk4nsw/5jCL6z1GomlxSicv16Ozq6ysxHZoEY0tJueydkqsHMazGIs5hYD7g1u
	 yH9CPMjOwh4+UzOCMTrwGjrbuZWJARvmdPH75CJKIGPvxVxOdr1dnBc4ZeecMIUmMf
	 oDRWSPjDOhryyazWdHG51zF9KANPGQrRwGjlKvalv+sv0AyL/srRVo/mgRKXAS+dhW
	 MUUPrXYWbXGKprkMR6fXcb5pMbCHqSi3iAohMSEvSL18DcuIdB9KB6DZykLdUh0o58
	 QOJMW3WKJ3rsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EFDC83F25;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:38 +0200
Subject: [PATCH RFC 7/8] nvme: Add Controller Data Queue (CDQ) ioctl
 command
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-7-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=dv2xzXC+6TJZt9TJ3U/97Y9njM2Cu8lc2Jl+hxwFXTg=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yuzaV4yProMruCg+StvkS6ozjmlyR+D12
 60MLLqag8RnjokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrsAAoJELqXzVK3
 lkFPhosL/10webJ+d9JVE+imM2vxDxzAqBP41TUHUEaBoxiWc5QMF2R1JzIGW6HrfyPN3JXplP8
 RAiqMmOBG28z+vGVt2c/BUKIlSN+X/ba7vXkGWIWjLqB+lMcr62mJDmf20cTjKa2pgZ1udbqd5G
 WuH1VkC4tDeGyvIy+qmgecW+zQOjUlTfeKz2e2KIhDgErp7m1GvTRXmQO0fsgFTIEhM5MEkoVsU
 U0VyNf/rp/QOKCrpBZaMapENcrGpmKv2U5uPQwPnQ0jNl2Ixp7Wq7xpVbMPB9JA9bdnlM4CFAHd
 A/oEsc7Ihe6HskrIrtsm+xziTjFUoPp3/qPyy7y1Y8cgMajjES9TZHKAH+G3KAOYHnvVDIklrCf
 Oo39RvqgS2nPGuakkWb1i4RR/D1NvAuJqMpZcsi+UinuTPgKlE3hn7Yg9fSdEnrH+ow4TeEV8lR
 qMQDd5+xskxvFw01WKi3VbpOeMhrKx+X1VQm1WvdjFN9sUlnpsTNUs5QsEmQFjxrE0Wx9kCe7v5
 6o=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

New ioctl to create a CDQ.

Creating a CDQ:
  Set the following memebers:
    * entry_nr: Number of CDQ entries
    * entry_nbytes: size in bytes of each CDQ entry
    * cqs: Create Queue Specific. Value depends on CDQ type
    * mos: Management Operation Specific. Value depends on CDQ type
    * cdqp_{offset,mask}: Location of CDQ Phase tag bit within an entry

Return:
    * cdq_id: The ID set by the controller for the created CDQ
    * read_fd: The file descriptor that can be used to read the CDQ

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/uapi/linux/nvme_ioctl.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 2f76cba6716637baff53e167a6141b68420d75c3..dc434628acc8462877e774a1eec9242a5df8a08a 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -92,6 +92,17 @@ struct nvme_uring_cmd {
 	__u32   rsvd2;
 };
 
+struct nvme_cdq_cmd {
+	__u32	entry_nr;
+	__u32	entry_nbyte;
+	__u16	cdq_id;
+	__u16	cqs;
+	__u16	mos;
+	__u32	cdqp_offset;
+	__u32	cdqp_mask;
+	int	read_fd;
+};
+
 #define nvme_admin_cmd nvme_passthru_cmd
 
 #define NVME_IOCTL_ID		_IO('N', 0x40)
@@ -104,6 +115,7 @@ struct nvme_uring_cmd {
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD_VEC	_IOWR('N', 0x49, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_ADMIN_CDQ	_IOR('N', 0x50, struct nvme_cdq_cmd)
 
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)

-- 
2.47.2



