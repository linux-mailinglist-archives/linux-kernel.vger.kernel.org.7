Return-Path: <linux-kernel+bounces-874939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D404C178EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91171350B97
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794528151C;
	Wed, 29 Oct 2025 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9ce3lKW"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9E275860
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698028; cv=none; b=JiwweQsnCp6/1bL3krs8+q5d/kL9N3sHc2Q2rA80itI2nmdLb8oiEYAssDHDcepw7ARVFsMgcJlKLxvYInzR3FWTDJI/bl2c1H0ZilBaoSMsm017UJyxnKORRM3m+aYKCBCwk5+py6l8wi9Zd3fMWAUL/s4GLPj8+5axIDRqyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698028; c=relaxed/simple;
	bh=xoymq5K4MSHYwMOKUgi996t0kFKE+yjdiNeUY2a/SVQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X0rkJ+ye1gCCEZ+OW4CY6pcdpFfc9ntdZBiOXx1YePleyfwGKP+SGXt2cFgY2U1CA2h/M0/1GmMVVTm8CFLQ1KlfdTJSn6yHinRGw+jjM+I8O2SvdtO/pib62BiyWiFi6TEK4ZWOSK9DCfNps2fG+l1VnMOVB0aGVOXet+hnE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9ce3lKW; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-633c1b740c5so7165727d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761698024; x=1762302824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdkzqzCHfZ6lX/G1aEBTisGzK+PfZoRnqikf15uBIgk=;
        b=B9ce3lKWRhU9jGJjI7bSdTsBCSyu+YqdT2VYcSb7M1C63KiI2NHmBtAGdgidsn61tE
         NR3ofRo7tXhsdV6AE5sOgx6P9KR+kDOGfQ2dA7CiE0zozd1xQFZqpux8Rz1/XljpyAiv
         pCcdpWApZi18ZNCxILzqov24vAR/itWXXApBTbSPDTRnV//tL0FA7Mee1DmS5z0/2spK
         Gb4FtxlBjHLFV/QJPntIEnMJHoCVKIYsaMQLz5wo5FqvldyMwNMLm/3J5A/mrP4gcPs3
         34jfW+YlgmWx9SWrccvpq9sISASJOhj4CUTsTdz3vBKO66jKR6ufp2RPNQI+h6FmVs+V
         4FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761698024; x=1762302824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdkzqzCHfZ6lX/G1aEBTisGzK+PfZoRnqikf15uBIgk=;
        b=iUoKHml35OobBGwPRLLaV0IWsCKzlgGVNLn6jAHXaGthr5KBK1a1aPPBK0WJmfWwHj
         QdLnIUju410OXHaIFaFS8vxAuCKtElPNJUMnv/4ttaA4L1zx/BRDOQPTEpCXZcIYbBGF
         eScPJMZBkrfCeEBsQecl4ZjWCTOGYK5JtRU9AYFTzE+Tynu6paAIdCBZ8JdzKq0vEmgn
         aDkwldWR1sAyKZlD55wfStYRq+MYBDyqUDETkLMJpP5tabG4U0JsFAlHGHQmaZH0JSoJ
         Ddr8ZxNfG36atWhSaGUSxI7GrvUlqCvzXwQoOCCq0z+euK0FsnY6VM03IOSMlQ3izX2n
         7mMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx+yXdNpuUxVjzWDbTAmc+X67ye/SXJ/uxaG1r1jnxtz5Xu+D9qdBsy4LNn2xVFKNd4X/8VaMOIZiu5zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67X6dkoTHEXsZEfiiLTq+Qhrw27gj0Dv/56lYiG09iLbJmg3e
	p8sHZmUDt4AM2e+Vmn7WG+8c2dR8X3URwWPmVIYToFA+LO0GQ0KM6x6hEf50KhNWtlTVjxp2CD4
	pYoDqQycgZDAb4l09eLNL0+4Ll++ELOk=
X-Gm-Gg: ASbGncu7DVXWPITgIYHbe12GggJj9mcbNaxaGJN6b7bisEWmVCaVOPR56bOdhMpszZX
	GY73d7fvfvv0YDBvunCqNhhy8bk3l9nunqYfy2FgNkYcBYiYTzVUUqPZjCgpSnt00CSTmqnfyHh
	6RTIgKUXDvYxN5LEl0NHX9zreJ+gKOuDbfx9pv2pgEdux/rYbGXVLONHDn5laaVIORim/7CCHhB
	IZ0TlcQ7IfKIovofKrxAVDcm9FUEv2yKA4dpH+jIDjJPvoUeC2BDO1KYOCDDw==
X-Google-Smtp-Source: AGHT+IH8PgR7V2uY37H0wYQDjQR6xlhgm7FhFPcPvl1vmv2cs7yqZ+C8q5wJQr019dnrfiwzfFBlR64OWNQipqYxDYo=
X-Received: by 2002:a05:690e:250c:20b0:63e:bea:b050 with SMTP id
 956f58d0204a3-63f76ce8491mr1103976d50.12.1761698024494; Tue, 28 Oct 2025
 17:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 28 Oct 2025 17:33:17 -0700
X-Gm-Features: AWmQ_bkg218Xr7uioK4Or0oWvQTwIEaOMn_DJhVceyZlHc7jfJr1jLfii0nJT1M
Message-ID: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
To: Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> nvme_fc_ctrl_put can acquire the rport lock when freeing the
> ctrl object:
>
> nvme_fc_ctrl_put
>   nvme_fc_ctrl_free
>     spin_lock_irqsave(rport->lock)
>
> Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.

While I agree that we can=E2=80=99t hold the rport lock when calling
nvme_fc_ctrl_put, nvme_fc_ctrl_free also does a nvme_fc_rport_put,
which could also trigger nvme_fc_free_rport, making rport invalid.
Should we also add kref get on the rport before entering the
list_for_each_entry loop?

Also, because nvme_fc_ctrl_free removes itself from the
rport->ctrl_list, should we also start using list_for_each_entry_safe?

So, something like this?

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b..fcd30801921b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1468,14 +1468,16 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rpor=
t,
 {
        struct fcnvme_ls_disconnect_assoc_rqst *rqst =3D
                                        &lsop->rqstbuf->rq_dis_assoc;
-       struct nvme_fc_ctrl *ctrl, *ret =3D NULL;
+       struct nvme_fc_ctrl *ctrl, *tmp, *ret =3D NULL;
        struct nvmefc_ls_rcv_op *oldls =3D NULL;
        u64 association_id =3D be64_to_cpu(rqst->associd.association_id);
        unsigned long flags;

+       nvme_fc_rport_get(rport);
+
        spin_lock_irqsave(&rport->lock, flags);

-       list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+       list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
                if (!nvme_fc_ctrl_get(ctrl))
                        continue;
                spin_lock(&ctrl->lock);
@@ -1488,11 +1490,15 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rpor=
t,
                if (ret)
                        /* leave the ctrl get reference */
                        break;
+               spin_unlock_irqrestore(&rport->lock, flags);
                nvme_fc_ctrl_put(ctrl);
+               spin_lock_irqsave(&rport->lock, flags);
        }

        spin_unlock_irqrestore(&rport->lock, flags);

+       nvme_fc_rport_put(rport);
+
        /* transmit a response for anything that was pending */
        if (oldls) {
                dev_info(rport->lport->dev,

Regards,
Justin

