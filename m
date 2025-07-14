Return-Path: <linux-kernel+bounces-729705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C6B03A96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF90170E44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB582417EE;
	Mon, 14 Jul 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swVGvptS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A723F41F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484591; cv=none; b=OxO98FIc1kSsiTaJ1eyQVhpoBtlq89u4TvQ0URu96AnN2tg6pJo3A1olYHH+Q7j4U6qZc7rC7bcGXcp/akRIz48ii6ctyK1oIrfWqzoH18xbo/9lTns1g5IfGINQ2xue1IV0lbUjlLDEsECBowVfnAWkuhNonEjk3gUFyHzKVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484591; c=relaxed/simple;
	bh=lwmTomBWKE8Fd16/Zh2Qe9kwiZVyEXAqd8HpaGKIrfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTeYxEdJhxxWubmMbiwSeEEzUN9ppChvtHK5yPhrhau92UwlaZiKoqoy9XiU7OH9A9SNe8W07igeSFAykgw9i/AE5kq6PiAMxFnwqhySDvRDcIR/tEnSVP7mOpSnlcJ8pPAlJgyc7BhP4M2nLGtLnXcKNWY0MmPL0sKVBI6nQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swVGvptS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 879C7C4CEF6;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=lwmTomBWKE8Fd16/Zh2Qe9kwiZVyEXAqd8HpaGKIrfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=swVGvptSMFOOMV7ImHmIDyFFsT4ndQ7Wqvjwdef0i6+fc/wA7WIPwrFtdTvrFDRiY
	 eh4IcRJacu1vaEK9WnuFsTiwvuUK56aQoEyfPrM+5/ORkMKK0Uzy/KcihfjMpEA50n
	 AZklIAZEkZlzrTvWq9K332w1Lb0hcS8LLczji0Kiv/Gok3NbMnpgw17XoXR6AyCxgr
	 oAKq3g1wcoQCY6Soz0mr8XSHzzSZOGNaZToorUyB8KoNo0eEaPrRyUQadkJgHaJo/p
	 wJ08I2G1L0humcq1aNs6C/FQSh8hcBDE2LWu/9ApQS+KR8ttMl2lqE1MD1T7ljbeNG
	 JBByCqvQK5O7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E9C83F1A;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:32 +0200
Subject: [PATCH RFC 1/8] nvme: Add CDQ command definitions for contiguous
 PRPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-1-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=lwmTomBWKE8Fd16/Zh2Qe9kwiZVyEXAqd8HpaGKIrfI=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yuk8GfwoY75hez1nZj0kKr5XnWOHgbukI
 9JpgO6uZi0vqokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrpAAoJELqXzVK3
 lkFPbggL/3XB2pAsjL3sKHaEN/oXQH2adusVp/KPNpHVTF6HFzd8CNfdj8yM0/08oL9Zv0CCvx0
 JyeBNW/uugwDdleya/LpBmpLQL5IM5j185NcqpPUHp+TbIPSjKvnk56/O6hn8zccX4MAI5GaoGz
 Xv/XQ67UlpIbz1OJ4kfCypoCfmtCwSMVOOn1+2kQ3HWKUgm32uamuDFonh2H2Jiq4OQUhzYptle
 Sb4psXJpbiOyW/Ubk58PiKB9SqSFIfUh7km3M8S936ElBCFXh8YqvkiT19V533XUTolsEKHifRB
 vLN8bB79Aqd6xywdFp2s2JA7q75tuEcaFGGSmKRTY5ucfEbDl8XzICgaulHcX8lpb4DinIyyi4a
 IxmmJ7tB0c1bEiACjIr+AJRir3tkw8sAEE+QUoahlGSx/6QrRxzp+ImSyhlUDGnv19ksqEDZdmu
 R8BP5p0GcMT42vWg+T7HWD+kwu0pWX7Fg+Qz8KbS9SZWMwi353Wo4ESMoTAOjhCYtE6sf7jiNN7
 K4=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add nvme_cdq to the nvme_command union that handles creation and
deletion operations. NVME_FEAT_CDQ is added to the feature flags with a
value of 0x21. nvme_admin_cdq is added to the NVME opcodes with a value
of 0x45. Add support for contiguous PRPs only; the non-contiguous case
described in the NVME spec can be added later.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c |  1 +
 include/linux/nvme.h     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6b04473c0ab73c61e208bb8fc230c2f9b65c69bc..7be6b42a1adcc3fdb3cec2e2d0e73fcf74244590 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5133,6 +5133,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_rotational_media_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_cdq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) != 512);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2479ed10f53e37055973ea3c899060913923fa62..a2012ec00e60c2f0de1b06599ba39481eebe4263 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1240,6 +1240,7 @@ enum nvme_admin_opcode {
 	nvme_admin_virtual_mgmt		= 0x1c,
 	nvme_admin_nvme_mi_send		= 0x1d,
 	nvme_admin_nvme_mi_recv		= 0x1e,
+	nvme_admin_cdq			= 0x45,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -1309,6 +1310,7 @@ enum {
 	NVME_FEAT_PLM_WINDOW	= 0x14,
 	NVME_FEAT_HOST_BEHAVIOR	= 0x16,
 	NVME_FEAT_SANITIZE	= 0x17,
+	NVME_FEAT_CDQ		= 0x21,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
@@ -1514,6 +1516,33 @@ struct nvme_directive_cmd {
 	__u32			rsvd16[3];
 };
 
+struct nvme_cdq {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__u32			rsvd8[2];
+#define NVME_CDQ_SEL_CREATE_CDQ	0x0
+#define NVME_CDQ_SEL_DELETE_CDQ	0x1
+	__u8			sel;
+	__u8			rsvd10;
+	__le16			mos;
+	union {
+		struct {
+#define NVME_CDQ_CFG_PC_CONT	(1 << 0)
+			__le16	cdq_flags;
+			__le16	cqs;
+		} create;
+		struct {
+			__le16	cdqid;
+			__le16	rsvd;
+		} delete;
+	};
+	__le32			cdqsize;
+	__u32			rsvd13[2];
+};
+
 /*
  * Fabrics subcommands.
  */
@@ -1923,6 +1952,7 @@ struct nvme_command {
 		struct nvmf_auth_receive_command auth_receive;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_cdq cdq;
 	};
 };
 

-- 
2.47.2



