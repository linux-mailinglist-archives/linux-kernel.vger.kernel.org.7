Return-Path: <linux-kernel+bounces-641186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7DAB0DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDAC9C4925
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAD27464C;
	Fri,  9 May 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrilwuXK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685332749D3
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781049; cv=none; b=pvP+Tgc3k7RTfxva7Iw67/yqQ++1tUm/DYJgbRWJ6G36mFNjp05lrD4a/laLnJyfEU+jdLf3zoXbgTOFweEo4B6kn9avFFo4bOJEpAhp4KSMlHe+bpVfoZzhCEnXb2F7Uof1drtyLm1b8BGjg2612T1VnclbV4ApEljRX6D5rWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781049; c=relaxed/simple;
	bh=hxfm1/bpj4A+7xki16WisjavPmtck8sx/M9OaVrjQjg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EqIwQ5ApiHMp0909Zyw+zM54WxUqN2pWifXBVNcXp0fw+pHkUQl9shHAKumpIUapLVJxuW8IrjIGp5jC6ULE1joJPDIEGhJ7H/YZnFWj2VxhuPNOp7uRLxVnyOAmvb0p3wgwH5NcGM2+OhvLjvpL1AZx0G31k64MS7SqH+06ZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrilwuXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746781046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KczM2UBQW66xcP870XQKZDwDetPPkSEynH8wmBTSFuM=;
	b=TrilwuXKv7jOuUGaxANxd+ndeM+VIVL+9PuN8LqgZRxg5eaknkpOZG6lPGL/nDkPtcMC3v
	cFnzxNWUDCR5VygyL5qjqy/ti+WddVk9JOmZLxNSq+UWCUiPxDZXqC4OxlsOczsSBylNtP
	X4rcG9YW22f9HDLD3nXX9TP8pTrGgHo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-GTArx9MZN3mKW9dKAlBzaQ-1; Fri, 09 May 2025 04:57:25 -0400
X-MC-Unique: GTArx9MZN3mKW9dKAlBzaQ-1
X-Mimecast-MFC-AGG-ID: GTArx9MZN3mKW9dKAlBzaQ_1746781044
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb94dbd01fso225973866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 01:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746781044; x=1747385844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KczM2UBQW66xcP870XQKZDwDetPPkSEynH8wmBTSFuM=;
        b=PAGRd0amBv7Awr2npOVhJtv6Ne5GvMEoUsCsmorN6Hf7Zx+TuScFRFW+A5HcNVOHE/
         3E9K+ABMy9WYg9pNrVEWACGZ7OFfFPnsfCXQOKV1W+790NQkas8K2X+8UKalN2tBgUMt
         j5qdtZLqDMcDlpa5ELWoAoIfWYGNjQwghON742voCPgftuRWTsI8l1gX+islvBAjwjCP
         hKEsMBlQ9/1ViGpnSuE+tn5g9X6LFy7xONyBOS7J0WyD8Ggg0vhr51cy63b33tuHpZNo
         x+cRtxnM517TZe8fSbrDmGxlv3wNhUgQE5C8dRD+2fIl05DJntPiHf/A9mNYl49XSQBZ
         0uWg==
X-Forwarded-Encrypted: i=1; AJvYcCXuS+oQCxYmWOepQDml2B1rfZpG/lNUtOA6F1M1HAWl9RPLH75BP5eTJdXOqNhpRgR4imJ9JJWfF5DEUQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPUgCrVBzmTtgCPzj4WKYuA+J2RKvWQEvPjERBrOXVCCpvSgu
	f80JL17nU+oeiSQJhnjs+kfFZqoPa9iMZASTHwrG+mT9haPWL19sXAMqsm+/X9n/6G6zahs880y
	jTyua27DBwyj1MukoX4D+sHFTEDGno+GMPy6SI3s6o8i9BHzmBWOAGCkga5J+BQ==
X-Gm-Gg: ASbGncujTfKh0dVf15DWIbQj/+0fmmwKLLYnef6zbnpw2wlq1xMWd/qZiuHG7GZgCcr
	r+KVLQflmS8nquLE1OpNXjlqm1t5cEmVRVGZRTNfGiH2GjtB7qCfQ8KT5Gj27Vo3BEnuBSplXm1
	PEODxxO2umH7Kga5/pFM3dnghzyQA5fb3juQBYu1iXYi570i9MU1aMcAPk7AQeREmD3qYFLjWlT
	r3A68BOVmrgGC2rIndpfSH7ipyRg2a7EIUC/MHngjYwPcb+AMJdaasJTwUjSQLQMnnzqRYgksWJ
	BHY5ygkhHW+7EbzCcKGoCXtMjQ==
X-Received: by 2002:a17:906:6a22:b0:ad1:8d47:f5a1 with SMTP id a640c23a62f3a-ad2187d9ff9mr242885366b.0.1746781043722;
        Fri, 09 May 2025 01:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHDBevO7YDl8KglZ476gaG4KxHzTLxc7mg7e0L2pUNIVoWmz4WZr1HNz4n0w09X6zYeiH0HQ==
X-Received: by 2002:a17:906:6a22:b0:ad1:8d47:f5a1 with SMTP id a640c23a62f3a-ad2187d9ff9mr242882866b.0.1746781042944;
        Fri, 09 May 2025 01:57:22 -0700 (PDT)
Received: from localhost.localdomain ([193.207.182.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cc4f240sm1085791a12.33.2025.05.09.01.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 01:57:22 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-integrity@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 0/4] tpm: add support for sync send() and use it in ftpm and svsm drivers
Date: Fri,  9 May 2025 10:57:09 +0200
Message-ID: <20250509085713.76851-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow-up to the discussion we had about whether or not
to add send_recv() op in tpm_class_ops[1]. Much boilerplate code has
already been removed by Jarkko with commit 980a573621ea ("tpm: Make
chip->{status,cancel,req_canceled} opt"). With this series we try to
avoid also the temporary buffers needed between send() and recv() for
devices that do not support interrupts and provide a single operation
to send the command and receive the response on the same buffer like
tpm_ftpm_tee.

The biggest advantage for this approach is with tpm_ftpm_tee where we
remove the local buffer and extra memory copies. For tpm_svsm it does
not change much since we continue to use the pre-allocated buffer,
to avoid making an allocation for each command.

Introduce a new flag (TPM_CHIP_FLAG_SYNC) to support synchronous send().
If that flag is set by the driver, tpm_try_transmit() will use the send()
callback to send the command and receive the response on the same buffer
synchronously. In that case send() return the number of bytes of the
response on success, or -errno on failure.

This series is based on "[PATCH v7 0/4] Enlightened vTPM support for SVSM
on SEV-SNP" [2], which is currently merged in the tip tree and available
in linux-next.

Thanks,
Stefano

Changelog
- v3 -> v4
  - reworked commit descriptions [Jarkko]
  - added Jarkko's R-b on patch 2
  - added Sumit's R-b on patch 3
  - rebased on next-20250508
- v2 -> v3: https://lore.kernel.org/linux-integrity/20250414145653.239081-1-sgarzare@redhat.com/
  - fixed comment style [Jarkko]
  - renamend `out_send_sync` label to `out_sync` [Jarkko]
- v1 -> v2: https://lore.kernel.org/linux-integrity/20250408083208.43512-1-sgarzare@redhat.com/
  - changed title since we removed send_recv() op
  - implemented TPM_CHIP_FLAG_SYNC idea [Jarkko]
  - removed Jens' T-b
- RFC -> v1: https://lore.kernel.org/linux-integrity/20250320152433.144083-1-sgarzare@redhat.com/
  - added Jens' T-b on ftpm driver
  - removed last patch since [2] is not yet merged and will require a new version
- RFC: https://lore.kernel.org/linux-integrity/20250311100130.42169-1-sgarzare@redhat.com/

[1] https://lore.kernel.org/linux-integrity/Z8sfiDEhsG6RATiQ@kernel.org/
[2] https://lore.kernel.org/linux-integrity/20250410135118.133240-1-sgarzare@redhat.com/

Stefano Garzarella (4):
  tpm: add buf_size parameter in the .send callback
  tpm: support devices with synchronous send()
  tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
  tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC

 drivers/char/tpm/tpm_ftpm_tee.h      |  4 --
 include/linux/tpm.h                  |  4 +-
 drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
 drivers/char/tpm/tpm-interface.c     | 22 ++++++++--
 drivers/char/tpm/tpm_atmel.c         |  3 +-
 drivers/char/tpm/tpm_crb.c           |  2 +-
 drivers/char/tpm/tpm_ftpm_tee.c      | 66 +++++++++-------------------
 drivers/char/tpm/tpm_i2c_atmel.c     |  3 +-
 drivers/char/tpm/tpm_i2c_infineon.c  |  3 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  3 +-
 drivers/char/tpm/tpm_ibmvtpm.c       |  6 ++-
 drivers/char/tpm/tpm_infineon.c      |  3 +-
 drivers/char/tpm/tpm_nsc.c           |  3 +-
 drivers/char/tpm/tpm_svsm.c          | 28 +++++-------
 drivers/char/tpm/tpm_tis_core.c      |  3 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c  |  6 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c    |  4 +-
 drivers/char/tpm/xen-tpmfront.c      |  3 +-
 18 files changed, 83 insertions(+), 85 deletions(-)

-- 
2.49.0


