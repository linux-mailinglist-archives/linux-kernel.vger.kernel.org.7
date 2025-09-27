Return-Path: <linux-kernel+bounces-835072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F5BA630B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072F1189F4DE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E84230BCB;
	Sat, 27 Sep 2025 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoeCAfxj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68718DB01
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759003246; cv=none; b=UlCQ6R1fqpGZQdfovW3JEhEocxBHmxdtNSBw3DPiKjhd8yEuI480YVW+4KTr/X6GhjyGZ5HPZTKcedW1dUNZBay3gYhlCdstcf7zp91Oi3f4eu3nMJnRyzXuP92ypzXLeM0Z372kny699B2y2+HSX/rV7Nnyxo4EDnpVy4ff2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759003246; c=relaxed/simple;
	bh=8pW32zcvR4dLYgwXXc+2tBLRJFT0Ej7KOCIhLsjxm6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcPPTSOE4fMmrC3xnKdNgFa4Ryz9YZQYVg/atqiQA3ZY4BTWbpMTGPyaHeHUZocTe6l4HV7cbFnp0ErY0U1+YX0oEIY28mNwI2PO/gSQR57GnQQYCMgBEr7B2GFJOw+I/o30djIlqVLbV7TCGW1x+Bs/JqLv+piomw40EWucgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoeCAfxj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759003242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LY7lMslLMdk6bP1H78HvFkKnVR2pPDQHspzHxpFwXrs=;
	b=XoeCAfxjSnw5qQHJrdTAHUVOPhIFinbPeIkxZaiVpkO3/lJBka6MVp7KxqOjd/RnpOH4Xk
	E/hA0/gywuEKB5fyo1D2BznscLOaND6AGxS0zSAigoEMGhpmkt3Y2DXxWiDqH/Y3FNpTtN
	zN14Qr2rjpIkNmuD+p32n0vPl+M+BSY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-oPbq-5R5NGGgHiDn8RpKEA-1; Sat, 27 Sep 2025 16:00:41 -0400
X-MC-Unique: oPbq-5R5NGGgHiDn8RpKEA-1
X-Mimecast-MFC-AGG-ID: oPbq-5R5NGGgHiDn8RpKEA_1759003240
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso2026418f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759003240; x=1759608040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY7lMslLMdk6bP1H78HvFkKnVR2pPDQHspzHxpFwXrs=;
        b=n10n71IJzNS15nuDYqmBWXtkkt6+72BHmJveiKbKo1rHzcWhI9kiMlpd+aSABG/YXO
         6S18USvxHlVBWj4iBIHJIRDq/bfWUBy2q+fOWyTQ7FYMwSavtnjKnCURwznR0PYL5QwE
         kZV/0oG76YFaMqY0X6wZaGTaEJvFKIT60V6VmDSA8oEnkABUrZ846+opvVNrKCuaeEqh
         I3Ta3wDdtBfbU5dcvLvUnJW26axlzPWBFU1pOHYgHuMcJEOnQoU2MbLIDOW4Ddmz+Pek
         e23aTqzg/Maxwq63tV16v/JtsRLqP8176HwDsHiYPIrJRvw2Bb9VU1LiY4bnzB9g8oYZ
         eRXg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1qU0ZHItHzVOWQmCMVcYuU4TI4/tyEvchtkB0RUSxj8DuzYVeg71Cv2eAELaufMkezvkAf5pcDtwleY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweCE5swBm9g1Cf13oD1r3ghSCmfcqb0fA8lD6zpY0/xoovRJsp
	GrQUk7FZxO1uD5VgcxcbPKtbTQNPdSWeRnHvOv8wdCYrA5fQ3JcfCTNPK8Wonmx6iwTRSxkuteu
	B21OoeFPaMvxq+AR+vWC2X3su9B8N7F7rkr5ULIDQMuRHX9BDMDFfFBT+qOy3eJLwwQ==
X-Gm-Gg: ASbGncsJVnI8Fq4DTMYeG2G24pH+4PPusWRWHmgukSxA1u7GKbJgT6DShtF9PKMkSLF
	uZiVgvWSeBjqKV5gP4RLl6ovn/6cbb63jwlxqpivHF1WzC5eCyLyul4ubgwHjAGi0EgYMS2/uhF
	Cwh+Ebxy7+dVRQNweTLfD19XXANsdh3yXkKfxlwYE+mcA6DgHUsG9BwSe7dC10Qi8tiq/Mg/kDS
	iSe4UfSfj0JDoc6yQovLkb7cMX1ZRifkc7sCwMNVsxdz0dtz0oeQPb5hrhd6j2jfJIxiY84EocF
	9ty9thg72IT9CRIAaRFxxJhv+f2033jxCA==
X-Received: by 2002:a05:6000:1886:b0:3ee:13ba:e140 with SMTP id ffacd0b85a97d-40e4a8f9a93mr9411610f8f.21.1759003239922;
        Sat, 27 Sep 2025 13:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnV16ZFd5HsrMWSnRhO0C2T0WOBDUOMZTvFfNi7AOVQpV95TyLimypxd7uEYgkUB8lVwvnvw==
X-Received: by 2002:a05:6000:1886:b0:3ee:13ba:e140 with SMTP id ffacd0b85a97d-40e4a8f9a93mr9411592f8f.21.1759003239406;
        Sat, 27 Sep 2025 13:00:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb19fsm12049208f8f.21.2025.09.27.13.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 13:00:38 -0700 (PDT)
Date: Sat, 27 Sep 2025 16:00:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 5/6] vduse: add vq group asid support
Message-ID: <20250927155955-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-6-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926101432.2251301-6-eperezma@redhat.com>

On Fri, Sep 26, 2025 at 12:14:31PM +0200, Eugenio Pérez wrote:
> @@ -166,6 +179,16 @@ struct vduse_vq_state_packed {
>  	__u16 last_used_idx;
>  };
>  
> +/**
> + * struct vduse_vq_group - virtqueue group

comment does not match struct name.


> + * @group: Index of the virtqueue group
> + * @asid: Address space ID of the group
> + */
> +struct vduse_vq_group_asid {
> +	__u32 group;
> +	__u32 asid;
> +};
> +
>  /**
>   * struct vduse_vq_info - information of a virtqueue
>   * @index: virtqueue index


