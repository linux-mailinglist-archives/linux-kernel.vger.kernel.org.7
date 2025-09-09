Return-Path: <linux-kernel+bounces-809010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC6B5076D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39166179A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B473568F5;
	Tue,  9 Sep 2025 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CYkh3ulu"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E025A2DA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450899; cv=none; b=I94HFXUxH7uyNwkN7QIdO4VKcGX1pJUN5Hlgsv7NLieK8kiEX3WVE3ZkFkQ5ru2OV9cTXNTZTd83u08FuNqsH38dyg0uUIEJbiMEimDUWGnZC91n4Y9FtrvRy87SJvuDZ3KN0rrtrCnKtXsjpAx0etdZe1NXUW98K6jJX4F2FmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450899; c=relaxed/simple;
	bh=4tMlFL0jeltx0SknTP6CLLeKBoDjimURJ+LLhcMnp+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rORaf28A9UOC0V7HXb/mpLSwyKwsnvS848hH3j+xgF8s6pSgLPz+Laz2Na4jbqdjEgdjOYabYJVcyFEg4fTPIECsDl98Zgb12tAupdb1dRxc4uP35PtFwi+cNTINUB5R5By+UKYnqoZxjBoU1Ct7nLdP2RobjDPazleGb9H/PAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CYkh3ulu; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-40ab48f3a38so10780645ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450895; x=1758055695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=54s/3TTnzAI7TJoX6IBsAb/akodWeIn3NxJpAHwYZFg=;
        b=W2oFmAPgm5mGVlE4apF3AI+6PT8uP2luXFQ6b6yqfB7dO0aZqQ0RKXSe3FuKviChs6
         5Plp8pPyjjuyga5wcpqXH/UFZPpmhYh8AEHDPtdoLBRULILYq/e0YXROtKQNttSJKz4N
         CXsxSFEBzArlPDXH3MOV1DhrF9w74s1JqNBBFJfQf5yX8aqAvIYwQ0UK6hl1DO7fxfQ/
         AZBdLAE8i+MfEtYFmS41ljh/zIUBNEdEQW4eHrHjHECSQNhDX5i0QQogww1QTtkGQSVp
         9b+HgILaf5zK1hX/4o2XRHLCvfUs2YAgmoIJ7bsN6fGzmKNP6BwopWj9Ad8+j9AqQ+Wc
         fBBA==
X-Forwarded-Encrypted: i=1; AJvYcCXZXDIxY3hhbXNdv5Jpuyj+khUMMLZEzNGYx2m21eRaPnCK1+OoTvTaVeVoHye7h0WHelBfynUHUH+tZ7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08RMjzgtFc6Yobo9qSLD/V3YVsKYQ28PUWsmNB0dIfPKn1Eg4
	UE1MCKx+cY045joTvKnbbIK4eLAngBMls904P+k+z9qLyLQlfFrWKQ3lhw9A2J4kIq0rXF4e/Ge
	otKM6xFQrySrBzluCnOb3gPr3AbQXTZuMhPZwrevX87dVRtdi+KC+oBy0KHRj1c3FLOqSa34Htl
	TQbJxeFAo7KfbZKVB1aMtpOn3b5h2JwuHe4W0FmHHdoRfZwUDxKnXg3YD6RDAbNnvPYtroWM2cS
	ldFvukfkRFblp6r
X-Gm-Gg: ASbGncuEHCJIZUGieYWOrSTu2pM+8QOXYeuGCYQ88ppH/oWdnDgijds3gqBE8WvrFDL
	xiICjVeh+rU6h3bwRQj7rz1iHhW6fcVLNKtgIkntouBtEPmgJaPbVAxtpaFaDytmoB26zIaAEqi
	6F7ymt90xA8zVM7GgAHZr1Td2vOcsRYI/O6rMquKSf1205/hjUbxukFxxLKAyJHESfVt9RbwIvT
	S/gRnBZBMRYgdh6FR/YRUqCN/kMPAJGCuzArPdQU60fdNOctNnrpvqCKpJ8nFyhZjnpi1lYGPPe
	qZeeSIM9aJRKIrPgTggWQznpm8eVemui+VZ77DwmqK/L/snUUuy78ta6qSlXhrlvAaMva6QXJ2w
	WqjIa5jDmCzN7pOY/veJn+LHYY+VhNgPCTpE+9J2XRJ/MBDtAYZXI4cOJaA8tzHVX5ooWzkBcG3
	Q=
X-Google-Smtp-Source: AGHT+IFijbDgHZyZ+md2UixUnGRel9qv56MFY3CuTmzZfw1DH2mO0QxxLXIWkPku8XzPXRXRS/bArlY/ofjM
X-Received: by 2002:a05:6e02:1b08:b0:409:88ab:d51d with SMTP id e9e14a558f8ab-40988abd7aemr117475805ab.18.1757450895165;
        Tue, 09 Sep 2025 13:48:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-408c292b1a9sm4985335ab.24.2025.09.09.13.48.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 13:48:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3dbf3054ac4so3593863f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757450893; x=1758055693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=54s/3TTnzAI7TJoX6IBsAb/akodWeIn3NxJpAHwYZFg=;
        b=CYkh3ulu9ZQbVTIGmX83urQfM7fsGI6HROktxSvbLYugZIf+DHPPwXTvnaX9ieqkNK
         Ed5SYhSl5t3+bgH2K3PPy+koQSHMT8fwN/MT8JT9pQ+QfCRKGHYg1FXuYP3ojguXtkod
         YpsNnGXXbt5qqA3EBe4W2cXC9g3w/JS6XTuvk=
X-Forwarded-Encrypted: i=1; AJvYcCXZDifvqBJWwnhzVG4Q/qmv5vM3HxzX3YQozZ6gq4xDf9geCOFeq65qI84mts6QtXTRzmFh3IyZ9iU5zMg=@vger.kernel.org
X-Received: by 2002:a05:6000:1ac6:b0:3e2:da00:44af with SMTP id ffacd0b85a97d-3e64317f1b0mr11871953f8f.36.1757450893469;
        Tue, 09 Sep 2025 13:48:13 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac6:b0:3e2:da00:44af with SMTP id
 ffacd0b85a97d-3e64317f1b0mr11871931f8f.36.1757450893035; Tue, 09 Sep 2025
 13:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908141152.221291-1-ryasuoka@redhat.com> <20250908141152.221291-2-ryasuoka@redhat.com>
In-Reply-To: <20250908141152.221291-2-ryasuoka@redhat.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Tue, 9 Sep 2025 15:48:01 -0500
X-Gm-Features: AS18NWCQbV405nIb5xe2AmrJdx5C-lN3YuXMGGzxAu05bgMD45xtWowVQdi89Ro
Message-ID: <CAO6MGtiOuQhGcHUjDjcYwnDrcZOWy9yM_kFwhxcTfbB-_OHQvA@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v2 1/1] drm/vmwgfx: add drm_panic support
 for stdu
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	jfalempe@redhat.com, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003c603c063e646ca6"

--0000000000003c603c063e646ca6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:12=E2=80=AFAM Ryosuke Yasuoka <ryasuoka@redhat.com=
> wrote:

> +static int
> +vmw_stdu_primary_plane_get_scanout_buffer(struct drm_plane *plane,
> +                                         struct drm_scanout_buffer *sb)
> +{
> +       struct drm_plane_state *state =3D plane->state;
> +       struct drm_crtc *crtc =3D state->crtc;
> +       struct vmw_private *dev_priv =3D vmw_priv(crtc->dev);
> +
> +       if (!plane->state || !plane->state->fb || !plane->state->visible)
> +               return -ENODEV;
> +
> +       sb->format =3D plane->state->fb->format;
> +       sb->width =3D plane->state->fb->width;
> +       sb->height =3D plane->state->fb->height;
> +       sb->pitch[0] =3D plane->state->fb->pitches[0];
> +
> +       u64 size =3D sb->height * sb->pitch[0];
> +
> +       sb->map[0].vaddr =3D memremap(dev_priv->vram_start, size, MEMREMA=
P_WT);
> +
> +       if (!sb->map[0].vaddr)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void vmw_stdu_primary_plane_panic_flush(struct drm_plane *plane)
> +{
> +       vmw_ldu_primary_plane_panic_flush(plane);
> +}
> +
>  static void
>  vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
>                            struct drm_atomic_state *state)
> @@ -1506,6 +1538,8 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_helpe=
r_funcs =3D {
>         .atomic_update =3D vmw_stdu_primary_plane_atomic_update,
>         .prepare_fb =3D vmw_stdu_primary_plane_prepare_fb,
>         .cleanup_fb =3D vmw_stdu_primary_plane_cleanup_fb,
> +       .get_scanout_buffer =3D vmw_stdu_primary_plane_get_scanout_buffer=
,
> +       .panic_flush =3D vmw_stdu_primary_plane_panic_flush,
>  };
>
>  static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs =3D=
 {
> --
> 2.51.0
>

You only need the code I've highlighted in this reply with some minor chang=
es.

1. You can call `vmw_kms_write_svga` directly in `panic_flush`. There
is no need to mark the buffer as dirty or send any commands.
2. The format should be hardcoded to RGB565 to minimize the risk of
overrunning VRAM. Adjust the pitch accordingly to 2x width.
3. The sizes should be vmw_priv->initial_width, and
vmw_priv->initial_height. These are the safe sizes for VRAM in early
boot and will work in panic as well.
4. You want to ensure `get_scanout_buffer` only succeeds once when
using display unit 0 since all calls to this function will return the
same VRAM.
5. memremap flags should be `MEMREMAP_WB | MEMREMAP_DEC`
6. Move the panic related functions to the vmwgfx_kms.c files since
they work in all DU modes.

--0000000000003c603c063e646ca6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
V0fYJUiKJMCwvDmndOil8EtMA8j2T6taUZoQINiKQ0oDWgY6eYVv7AdPVIeOOs3noCyUL8AyA7Bl
yoOPBB2/gk8VGcolEKgAAj+3hPbBF/d19x1bZzU3wABizBomVwykx5ms1nVXDbQajz8jqYECKWh9
3OMo7BuC3TAClu5mLr2zs0Ccpp6NRRkjTF8WtCJ+jSnjFJGLAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2lhbi5mb3JiZXNAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSvJWzgGK7aSByS+CQVBVfM
Xgm5azANBgkqhkiG9w0BAQsFAAOCAgEAfrWiLF3zrYq7D+KPNRaAP70FbxHeaiUfn27Hbu37Eefz
xeJTcFZH04IEtXqpM3NWYZm4A/dFn/VQPbLCRaeXzpT2TESVH6EFY7BEF0rnSSlUbFyi000MnSH3
h5m+MoyE+PzLqfzLBZS+EU/haCpPy6Nqhs3fPKG3w5VTnUPsAxXK7rSmkIDVNsvwRttuMq9KHJzH
Bx51dP/z3mel4OuMjgrwHk5uNY1Sn1MZAUQztVUsWguyfoKcmhxXbBccR5DdEfBgDEbq8bicPQ3J
kqEy1QZXJfHlJuAJIiEw7odGctwqLeGCU6cBLhnsg54ngjO3uYC6tIySul55MRxFKE8HIwIrx+D5
2SwhDeVLZ8sTK40uPzW5xg5laOWVCvmy2b+cHCGzarUeIlYdtw0ejdH9Hbkm0G7IrDvjkhPa64gR
6Q+m5CGRDk+8iWhieH6WFE4HL++BpZhoi+YsOkGU3DK0dA+pxQnXNcNw1s0eNbSUVwQzmlC4LqiK
Gj5JV81HTPLhoAya57a9i28Fp5qHZiFnCq4HMvwiwY7IWe+UwUuueU199aTK80xNiS553vHc6FpI
/vxGy+LveJqEtodfKqQKwDOVu//c1Lz3uergJHqFYTMykk5U95J3FG5q/7Mqe4RF6E9OgtuAJidS
6Ca5anjLQ/qzIfTjoXX7TJSjPztehRQxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAOe
QQoRdqGBHF8MTKGHzMCPvMDcSHfa5h8Pj/NyD0+iMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDkwOTIwNDgxM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJcgYNAHs4HVyhJ/zQxQwhM0hkopWe5peezRZr/a
1WGD0ib5CknKC1r7L68QsZachJOZNYFucHHY1JU0kLse1wBNiz26spjWPhrFuQQH3s3+rP4DSvEn
DyhD+18ac1FigQUbTQ8G1JAVxEFuo+gce/67mE9PCNbcxqU6YvOqOeg4x3/1RLWoxmjf6ePm7WiM
kp/w3wyD3qNuQaEVRpJENWwU3w9r1wY/F3MfrBy9ePe82pSiGmRpvJIWpMFVXRFBqj7iEFF+4ZYI
WL0xyST25HXjh0tHrWDgmO+045IL1IAj2dKXzgIZwb0FPzdueO5thR1kfqBjDM0tb6zvVF/C0mA=
--0000000000003c603c063e646ca6--

