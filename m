Return-Path: <linux-kernel+bounces-824046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46CB87FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706651BC7EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2192BD5BF;
	Fri, 19 Sep 2025 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C+QsZELD"
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA821FF24
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263350; cv=none; b=qCLdZ/MH3UtPhVeX/vxYqwIBS8D0FmcJvzX1BSHtrAC0A9NhHWfFcZSZbiQ9UxhhxRFIJX9vyJwgHnUNQ0HVoFBw75o2WeejJM1TiaeW8+z0CgUmhno/Lgp/XmrNZE0ov+ntZ5JWn6sXWQRGKlg2+7/Pvv3Jk+CzQKPqTNvEnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263350; c=relaxed/simple;
	bh=uzfwjgumbFwr7laxCjzuhxg+2KriU+dpv9UN4OiCbog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo0Rd2kFgJGshR/KvFudOnTjcxSuCHsHHnJ/x2V9vdwMWVFW9NMbVVbrTWG3xMnMbTmROnPB1cS/iTwunV3dSd+si36TvP/oTCXlUJNL5dt6qOQ2NNnbSN3ycDoFxZT+I4ltn0I1XDDnvL6cn2FZSRZRA4wM/ThtiZJuoLyR3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C+QsZELD; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-71d5fb5e34cso18190597b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758263348; x=1758868148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqcrUYNGnSKH09nNEKsYPiIAAW+/2TxUpcW+Ql48jlo=;
        b=cNbJVe48ApLZHF9ZAYF9fjVIzmfuCstxpxm7ktMKyXCApFzDea54upZ2J3pYp1nZzb
         KrfiZ7MfyTi/QXkeMUiEVwVbwnWnlwCmMc/vI+xtCqEVRvXx81Wy92x3tapp8e9YfrGm
         ZhaOp0R/3Zn+qNXhqFZgsU80mCqfRw+C3hrEl5MaqOdrqnODbYL2tP92WQkQvAsSlICY
         Wb+eqLWzn1YMYXyRFpBwx5rfaQowKDq59ibQuHnyDrUiAAFp96bSkcSpp+ZgNLIeRj5X
         z0oBP2vDFm/B8XI1JvusZAGQ6CiCKvrlLg9GKR8fT7YrYBz2Q041x3AoxfQowm5e4QY6
         UlRg==
X-Forwarded-Encrypted: i=1; AJvYcCVqrzIxqV9QjnWhGR1s5fDGWDLvT5uUqEyqnhEDhcCteZ/3YRjpWQ1zYaiK66gm598lTdX+/q96FxA3hes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyth7GInesOVBj8HaCs+yZoU1IPzs5Aw/IZFefrbYXxSXO4xYl0
	pVLJwdEG9M2iiRvdp3YjFedsh2GyaXwWGsgCmU2PEtqDyQnjkRW5L8J8EhPdHjgAHFcUNITaFj5
	Y4GhcYL6Alm3R48kCv49DEiB07JFv8AJWp+hQ39GbA/jAj5rR8CK6mFccwvtdj5VUz/TtDGrDTu
	OaGoHx1eItC3dehIpu8wlj+NEpHgJ0e9bmarGeyMKcXejN1JLVhjQgM0lMRDrOCfk4El2/MMkNZ
	xuhIPYUBNEAKoQeGhPH2IAFqQ==
X-Gm-Gg: ASbGncuyJcAXOxjxTR8KQz/if64Z/ctFFAnp43pDXikWM035buVlkPnCCTPJDS+T87d
	qAKjsLRL2IgifHouNkMjWQsaIXyvHNSXt+vm8CsVDkz9+2Mcep9UNnvZ0Ddr3CUTYSwTBwbtaZT
	d8S77tgtsE2XQMgQYlaSSX26ZnYQym+Mbx3kJ1UazhPQZc/88lLJ2GnQY30FeCtlTaBcEs/qAvY
	hjR6JxSxKwdETEndFqhYxtTTXjC55D7WWjWNaE1cfob7FgJlhIEzyjwAUbqYs2sdJDNNCP6KCDu
	QVsVqTtiw7Urakx3lFTJKWE8hmwWifEjIQw2/fhQ717Tg33y/s5X4ZHnRXOf0AsxjFdKwDF4zV2
	bMgz4K23sbyXahsYYw+k0VBaDgWuW9pOj11difCVRHXMGgacZtmhvaCIpYV7egVOeeBWdP35nvk
	b9J2evQaMV
X-Google-Smtp-Source: AGHT+IFPUyl34IDfPbGTWAp2J4U/pTAqBcW+PhwLSmrZvsCFOBN2SmDJIUXWkaECBTpHuOuqXx+GqFWb7GBE
X-Received: by 2002:a05:690c:690e:b0:739:f055:c77a with SMTP id 00721157ae682-73ccfe3411dmr23014987b3.21.1758263347813;
        Thu, 18 Sep 2025 23:29:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-633bcb6bbdbsm263849d50.0.2025.09.18.23.29.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 23:29:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-267fa90a2fbso31503705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758263346; x=1758868146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqcrUYNGnSKH09nNEKsYPiIAAW+/2TxUpcW+Ql48jlo=;
        b=C+QsZELDjVBtkzk9oVuBx80wqsJ9Sav1qycdzjtN2U4mmG2RvxdOiNqET4iF6y+BCK
         pf5bNWCMFP6NVpohUn1RiMFT70RsFeLwepAsi7I935lxiSWugaMYfMRGa1cvNJ4L1PX3
         tcsn6YkCOA5AVN2X9VyGMX0HzwuV4RWFtHn+E=
X-Forwarded-Encrypted: i=1; AJvYcCWLe1O+u1cQiaZE+L4erhqmfhTIHqgab4RgMDOO6E6x990SQex4IJI7k/6ykqJ1drcuoPeRYVcxTcamnIc=@vger.kernel.org
X-Received: by 2002:a17:902:f54b:b0:25b:e5a2:fb29 with SMTP id d9443c01a7336-269b7f33d9cmr34750785ad.12.1758263346516;
        Thu, 18 Sep 2025 23:29:06 -0700 (PDT)
X-Received: by 2002:a17:902:f54b:b0:25b:e5a2:fb29 with SMTP id
 d9443c01a7336-269b7f33d9cmr34750475ad.12.1758263346118; Thu, 18 Sep 2025
 23:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-10-bhargava.marreddy@broadcom.com> <aa898848-810e-4a6f-9fcf-0289e620229d@oracle.com>
In-Reply-To: <aa898848-810e-4a6f-9fcf-0289e620229d@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 19 Sep 2025 11:58:54 +0530
X-Gm-Features: AS18NWA4g6se1yHRd8pRQwxwLRc1gUdB_L_j-Q2O3237PRKUWY7oS38bVFaSUkA
Message-ID: <CANXQDtYuJNGiYswsNhwLuVvm=OJ=Nzgc8p6q+G55KykHtri+jw@mail.gmail.com>
Subject: Re: [v7, net-next 09/10] bng_en: Register default VNIC
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Thu, Sep 18, 2025 at 1:48=E2=80=AFAM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 9/12/2025 1:05 AM, Bhargava Marreddy wrote:
> > +int bnge_hwrm_vnic_cfg(struct bnge_net *bn, struct bnge_vnic_info *vni=
c)
> > +{
> > +     struct bnge_rx_ring_info *rxr =3D &bn->rx_ring[0];
> > +     struct hwrm_vnic_cfg_input *req;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     int rc;
> > +
> > +     rc =3D bnge_hwrm_req_init(bd, req, HWRM_VNIC_CFG);
> > +     if (rc)
> > +             return rc;
> > +
> > +     req->default_rx_ring_id =3D
> > +             cpu_to_le16(rxr->rx_ring_struct.fw_ring_id);
> > +     req->default_cmpl_ring_id =3D
> > +             cpu_to_le16(bnge_cp_ring_for_rx(rxr));
> > +     req->enables =3D
> > +             cpu_to_le32(VNIC_CFG_REQ_ENABLES_DEFAULT_RX_RING_ID |
> > +                         VNIC_CFG_REQ_ENABLES_DEFAULT_CMPL_RING_ID);
> > +     vnic->mru =3D bd->netdev->mtu + ETH_HLEN + VLAN_HLEN;
>
> nit: does "struct bnge_dev" hold a netdev ?
> if not should be bn->netdev->mtu.

Thanks, Alok. Struct bnge_dev also holds netdev. But, bn->netdev->mtu
looks cleaner, so I=E2=80=99ll fix it in the next patch.

>
> > +     req->mru =3D cpu_to_le16(vnic->mru);
> > +
> > +     req->vnic_id =3D cpu_to_le16(vnic->fw_vnic_id);
> > +
> > +     if (bd->flags & BNGE_EN_STRIP_VLAN)
> > +             req->flags |=3D cpu_to_le32(VNIC_CFG_REQ_FLAGS_VLAN_STRIP=
_MODE);
> > +     if (vnic->vnic_id =3D=3D BNGE_VNIC_DEFAULT && bnge_aux_registered=
(bd))
> > +             req->flags |=3D cpu_to_le32(BNGE_VNIC_CFG_ROCE_DUAL_MODE)=
;
> > +
> > +     return bnge_hwrm_req_send(bd, req);
> > +}
>
>
> Thanks,
> Alok

