Return-Path: <linux-kernel+bounces-867709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA7C03556
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F323ADCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AEE34D4C1;
	Thu, 23 Oct 2025 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZCAbHQm9"
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5CEEB3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250375; cv=none; b=Ji9mU9twQFQQTVH5YB6n2IEjY43hbMuhRklUW2tw6e2d+2Zo1PzwTmbBVVHBGYtemw6dLlpchXoG59JtdLNawYGA2L3aJ9qnclM/WqkYzRa26VnZuKu6gRo0X6iamowvUHj2fVh+FnjYCVl/qoA1flWsefyToLG/OlF/UHH6mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250375; c=relaxed/simple;
	bh=OCnaonNsZfwYtY8w20ajyelkETsp5k33ujjnYrk5kNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkoBmBPPd34LcZqN6lqAP+rg5SL4TXDUZy9DwW+bCS+JylLBy1PGSN83WGKTYfPHFCtHlnNF7+VjcLlmPLpXjWfwSOY8gEAQ4JjBEl+CPXaLbFvNoFCKfcXTutXNebQlwSW+Zwqs54Cdrbk8pJcHXr2Be9Mp3qM+3cx/5+Ez++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZCAbHQm9; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-63d0692136bso1564082d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250372; x=1761855172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfKzLamtfyKDr/ZoLAnuN3X3QCSid0OYX3ziX7Skv84=;
        b=tafca2nr1mTjmnJFkPtS5cEC4qbL7xnCZ2fW+mrXZU0HU3KGMuxX92XFeBUgM0j5RV
         fSiNbQtRFDS6TqHn7kSuDPC/X1QLJs3hwjUjBBudQftDddo+3C/p55KdJ1VS3THL/iJE
         7keHTPo8l0Kev5zjaBOfHejrYGNRpXnFohf9ImdM4uqkF7K63ocl4ywnevg6nIel9fpl
         wNEp5JrPDyRaHN+NPDeee1+87zqAVhyB1oQNYAMau3c5kEVbNGKmQmEJALVLE5ee6ZA2
         6ZBolX7jm2azv0tb65SF+HB/qu03gEuuYRb5QoOT9HL8xhOIJiV2dYHirVjyM5PYnNtH
         3FUA==
X-Forwarded-Encrypted: i=1; AJvYcCUfDa2JE8RQGJgtTKM5YhSUkenexq6lR/4dlUiHRE22rF2lFNLODJxsuNPlYiQGCMTiRThXZCVV6XJZK1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzOik+hnqG6LLPKZRua85N2+a5n1dIVk6986hYaZhBfNEYIWpt
	DHI+zLV6qbIEDBhHjjalitAFKldeHIff9xRUjy4K0GgUx8310X85CNIwNEhlonJwMFb8oYhzIP9
	EMsUiFaQ1jINW0I0vdUoZfWPUvgc1TMPG/lz3LGN68he2rCAOjIUkoKyhlTRbluOXtFv9oI5JEd
	ZDycNJffOuH0/JqWvzHdq6vNAL1p0H1rn9WKMAt3gUNqLZs793q02Qb4AKw2uAyi3o+QeDzzad3
	B63meit0r9zuZE3
X-Gm-Gg: ASbGncu9uCkFISctLVN9kftVWHw88K2KJ3K+Dwbwk7Nas1UKQGRyzf14X7u5lqDbBzx
	CrNydYqzsPK1sDvgIl7K7+35VQ+FEr6HAlm7nhINpEXWnVa9Vpmo2k3sw0qQdUN9Zy+zphGJx0i
	go+M20F0l+KVXXpWtBu1lP5QUnGqP/kQK7WZ9jYgckkv3Be2VwYxtSu3VP2JCgtiJ/QKRElHHVm
	k3B8R3/OYVoATLfIwdJvBWXXTHCcM2bRGP8votezGQ5Gxw2P2fj6TOoohcC4lCPqIKpUnO0cV+8
	ilhHglkRmI9BZXzCkV212X8UtL419Ym95W0szhCE+62YDQz+EGSVtae/9aRA+lzlkA1Tw+bROKz
	Xpoj4dVM+6qV5oJGZJboEIWa3AT19pQMFCf+nN7A+5TudTBe3hkAnjsuDg1EevC2MBEI+6RmoFc
	Azuzt0JXpknXIRXttG9RQEh6iTpI4ihKg=
X-Google-Smtp-Source: AGHT+IHM6PeA2ZUSFAY0Rd1xKWYNlOkOHisF8hzCfd/oxsyXHP3NvXjqlvP7M2C8PdokXmM7JHmPQ6hQW1Qb
X-Received: by 2002:a05:690e:408b:b0:63e:2324:9ddb with SMTP id 956f58d0204a3-63e23249e5fmr17588140d50.65.1761250372177;
        Thu, 23 Oct 2025 13:12:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-785cd6c35e9sm1444567b3.19.2025.10.23.13.12.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:12:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426ec5e9278so781948f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761250370; x=1761855170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FfKzLamtfyKDr/ZoLAnuN3X3QCSid0OYX3ziX7Skv84=;
        b=ZCAbHQm9whaD5BUcRzXSRrvnVnJc4/enkuN0sKv1zOZN4hsKbO137w1XJIgtMUb8Bu
         ccs3asmz9jJpS/gFWffin9Y0XQcLT2Ar4najFdk8MWI4jhPCGOR0ocDKD0xpNSz6R28C
         lQkc1Mbzu4RMEcPPOJoBG+mkiNFLDauZWN4VI=
X-Forwarded-Encrypted: i=1; AJvYcCUCmaQ4Wo4fa6B25pcod7Cc+M+Qsd49ptTuVXGktXWOB6RDtSSNXe2Qo3jy3OfeDij174xxNE9EzlliTKI=@vger.kernel.org
X-Received: by 2002:a05:6000:310d:b0:3fb:9950:b9eb with SMTP id ffacd0b85a97d-42704d90129mr14161476f8f.28.1761250370397;
        Thu, 23 Oct 2025 13:12:50 -0700 (PDT)
X-Received: by 2002:a05:6000:310d:b0:3fb:9950:b9eb with SMTP id
 ffacd0b85a97d-42704d90129mr14161465f8f.28.1761250369926; Thu, 23 Oct 2025
 13:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919032936.2267240-1-ryasuoka@redhat.com> <aPEFs0kYfXGZUHCA@zeus>
In-Reply-To: <aPEFs0kYfXGZUHCA@zeus>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Thu, 23 Oct 2025 15:12:38 -0500
X-Gm-Features: AWmQ_blwB_gCW_dFnQhGJNNmgUmY3G8S1CM4WFjSPbYzJfqKKWDZTnBoJ8EvTPw
Message-ID: <CAO6MGtj5LCKBJfTETPb_dUBSVO3de8hZLUMSm5thyeMeY8bEXw@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v3 0/1] add drm_panic_support for vmwgfx-stdu
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	jfalempe@redhat.com, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b5d99e0641d90eb7"

--000000000000b5d99e0641d90eb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If it doesn't work on vbox that's not really our problem. I've sent my
version [1] that works on Workstation and ESXI.
Since it has less code it has a much higher chance of succeeding in a
panic situation which is what we care about.
Feel free to add whatever tags you feel are appropriate on that patch revie=
w.

[1] https://lore.kernel.org/dri-devel/20251023200447.206834-1-ian.forbes@br=
oadcom.com/T/#u

Ian,

On Thu, Oct 16, 2025 at 9:48=E2=80=AFAM Ryosuke Yasuoka <ryasuoka@redhat.co=
m> wrote:
>
> On Fri, Sep 19, 2025 at 12:29:29PM +0900, Ryosuke Yasuoka wrote:
> > Add drm_panic support for stdu in vmwgfx. This patch was tested in a VM
> > with VMSVGA on Virtual Box.
> >
> > Based on the feedback for v2 patch, I've made the following updates in
> > my v3 patch.
> > - Use MEMREMAP_WB | MEMREMAP_DEC flags for memremap
> > - Use vmw_priv->initial_height and initial_width for sb and VRAM
> > - Move all panic related functions to the vmwgfx_kms.c file
> > - Ensure if the current display unit is 0 in get_scanout_buffer()
> >
> > I did not apply all of Ian's feedback in this v3 patch for the reasons
> > outlined below.
> >
> > > 1. You can call `vmw_kms_write_svga` directly in `panic_flush`. There
> > > is no need to mark the buffer as dirty or send any commands.
> >
> > In my test environment (VirtualBox), the panic screen appears unstably
> > without dirty command's submission. Without it, the screen sometimes
> > appears immediately as expected, and at other times, there's a delay
> > of 15 to 20 seconds. I've also observed that it sometimes only appears
> > after switching between the VirtualBox console window and other windows=
.
> >
> > With command submission, we can stably get a panic screen. Even if it
> > fails, we may get the panic screen ultimately. Therefore, I think we
> > should retain vmw_kms_panic_do_bo_dirty() to submit commands.
> >
> > > 2. The format should be hardcoded to RGB565 to minimize the risk of
> > > overrunning VRAM. Adjust the pitch accordingly to 2x width.
> >
> > While it's possible to output the panic screen with RGB565 by adjusting
> > pitch and width, and BPP on the (virtual) hardware side, this approach
> > causes debugfs to fail. It appears that the BPP must be reset after the
> > panic screen is displayed, and there is no way to wait for the screen
> > to be fully displayed within the drm_panic handler code.
> >
> > In my test environment, as VRAM has enough space even when using
> > XRGB8888 (32 bits), I think the risk of overruning VRAM is low. So I've
> > kept the default format and CPP size.
> >
> > v1:
> > https://lore.kernel.org/all/20250901083701.32365-1-ryasuoka@redhat.com/
> >
> > v2:
> > https://lore.kernel.org/all/20250908141152.221291-2-ryasuoka@redhat.com=
/
> > - Map a scanout_buffer to VRAM in .get_scanout_buffer
> > - And then write to VRAM directly using fifo in legacy mode to avoid
> > allocations or command submissions.
> >
> >
> > Ryosuke Yasuoka (1):
> >   drm/vmwgfx: add drm_panic support for stdu mode
> >
> >  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |   4 +
> >  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 165 +++++++++++++++++++++++++++
> >  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |   2 +
> >  3 files changed, 171 insertions(+)
> >
> >
> > base-commit: d41c79838c47bc822534cd53628fe5e0f8ad2424
> > --
> > 2.51.0
>
> Hi all,
>
> This is a gentle reminder for this v3 patch.
> I would appreciate any feedback when you have a chance.
>
> Ian, your feedback on v1 and v2 were very helpful. I would appreciate it
> if you could take another look when you have a moment.
>
> Any comments are welcome.
>
> Thank you
> Ryosuke
>

--000000000000b5d99e0641d90eb7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMdv+fjzxf0KFt9De7MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDcxOVoXDTI2MTEyOTA2NDcxOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKSWFuIEZvcmJlczEmMCQGCSqG
SIb3DQEJARYXaWFuLmZvcmJlc0Bicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQC2AMlK9RdoCw8arN33t70vxMApCT5iWUWUvifzr+uPD1yUo6FYiadl5yCjOgy5+a/b
yDWISjqDL/DJ1OAopJ9LEPqznspPNSFvQ9pOB7Z3CIITWi2QoSJMjlmG2GIXLe3wQQJ9CVwF8Dlc
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
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILwK
q+o3rnSJM+at5TvoiyKUdvZFFeNneK4koKCKjoqXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTAyMzIwMTI1MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAG5kjOK8mVQWzgbKj2Bdi/Phz6H8Qtz5acoZn47G
x5VuCpiRImy8rqpceLCTA8qAJgOPYl89Ia90WqjYgBQpx6bHodpQqAerWk3EMUMjCSDEu/e/bD65
dzLg19OTyE+fLkE6PDa+IsZbd2Ldo/3XtSiZLQL9znOZkLjv3TVoxNm40QayZJKDNG4CwWbNQVih
wdNm4YNvvHQuyz5vRI5/fhg7CqNVY6DCFPDWNRRD7NUD3paoGVRuFwUR5jh8M8nXfKdw15EfRvdD
TqDlCBIvNolUZeeobMtmSRlRwgqkojOVCqjiLgIddMtQX3IzN6QE6R8Llr9CklXTkl+4duMNWcM=
--000000000000b5d99e0641d90eb7--

