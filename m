Return-Path: <linux-kernel+bounces-889101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0C3C3CBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8E564F4F42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50734D92F;
	Thu,  6 Nov 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXKpyi6O"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10CE346E43
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448730; cv=none; b=J3aZB0t4mRgBMalNE+Bz0AflT/B1nzWX1oipSKy7kmm6d9OndpQK7t6ZDu3sF8NjIiKPA6Lemul0ZA5FSqZzCbxpe5+r3EEq05//SBYU2eGSA+nPJx4W6vAKPPSH82/5Y/+M/EbIKXvAlh0sbTkdKifsQNGnsoxBZn0NQWiQr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448730; c=relaxed/simple;
	bh=S+Y3kCFJNgHWucN0B4zeYI4067m9L91pLXVFaen4Ey8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctjYQsw4roXNamhWaXODIi9kp2mFPkS3m74ZX14AmoT11qWhCs3dSYjS4OZM8r1Ez5O2/kcoJ5/bkk5Ebc+v7pRziU9fPHpszp/4FIARh26TfptvAJ9ocMY7zBf7e2enl+X67sR77HGHI1j7CFPxzO3tRiwSisxtrq6y2XrTUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXKpyi6O; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed6ca52a0bso343561cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762448727; x=1763053527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scJ6k0bT18jsi+qLMCxZ7cxZajHLD2rBaXSvsMOLkH8=;
        b=OXKpyi6Ovu5Cm+1+doT6yK0k7ufaazrjqrmyOllnKAac0jnQ5tZr6wHjhOaA5nPuxa
         kxZRtP575IjjJObyI8HTyzbV/CzkOf3WPaX6gYObGkmL4nJhEPm1gQEoNGENl3uN1bTt
         Iz86Z93Munm8ZDgtZ1EwupQ9ZYaj8q1PZ16VIzhhMzCj8tDo/8XpoFXxYsvP7wEZZchg
         1m4euMs1dZ4lvQq0Rsuvy7H3vEYxpceafyqbDNPptpUlmjg2am2G25VyhvcL+OGOmQt1
         Dowvp6rZ+GHpE+VY7an2FuDurc6p+Y93I4x8Q5vsCQK7DUO6mVzRWTIDXonXvhFSJdVu
         oo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448727; x=1763053527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scJ6k0bT18jsi+qLMCxZ7cxZajHLD2rBaXSvsMOLkH8=;
        b=rSeew6nN3iKDqJVu7S2EkATHjPZl1bhAN1nZwPFeqPfu9v8M63xEAT6Yp2BUejlHCe
         yuj3AiFVFahbcXfah9/h9o09hPcEx8c9Ys4unUXioN32pFjOqqABtpL0rELb7xD+NwQF
         emPoO17EDlKwxwevkrINdH01XJDxt1gopVFkJrDB5shO1hnpEOMgWMRS46IqDE7YSvZu
         OAcy7wLc+yEPVmeFa1pBbPyvqB4iiV6IIyCAM+6gLRGihpTHwO6dc7tx1gJmVuTddnEU
         q36GfaIbRAnyxqfT14pKoeCRiKjRVF+/vjw/pEuh4ZG9n8LIss5jkalg3YgzgKV2UBEt
         Lqdg==
X-Forwarded-Encrypted: i=1; AJvYcCUCiuy2IjwYAEjPLSN9D4HMZYdrErWJqmM1t5yFZiRwtEOltNrKMSj79yUgliIi24nvQK5cfE3sGThzq2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/IdXAk77irXoZLClLqLhjrFOiMjtSvU5oLZM09ayhbtiGv/Wa
	tRCXxenhAlvmpsmCvX1D66KEXkMorGC4aqUenVAGWCSqFEJjGml2UkZ2lzg4qIqAcDjjqz+iyNO
	Hlcf+sbwpxZQpKtmIQ+ALjznHEcCUdw7V1eE6zL8j
X-Gm-Gg: ASbGncs41mZ36aT67nT8VnJm9ecQiCHcv5ztMA9YEcyQ6gjchViZ1HKZVy4b7GL0x88
	ZKSLkU5dayrX5T/vpaZGfgY93+s7yTUAwt62TUC+U9FuSFc6NorDyvdKPwhgTeWqtpq+IFGh8a3
	yGzax7EqSs1Kql0WTwlHbxkjcNVUG6Eyc1Gx4egCt++SzzQmyOaRBKm4st8i67+obn/38wNLeJF
	+BhnhuMn4RslfDJbPzjhr4GK788v445ibt6yLlRgGkitxSnKps184qjQBzV0vQT8mFjNVI=
X-Google-Smtp-Source: AGHT+IEOTmFEPSRr3a0jpxj+r+E02+Lm0ju4YokyrsnN77XVtO8mUbijvLId/05EmEWcLoBmxC317bOYRuPnYZedn74=
X-Received: by 2002:ac8:590d:0:b0:4b2:ecb6:e6dd with SMTP id
 d75a77b69052e-4ed82b49f06mr6510301cf.1.1762448727258; Thu, 06 Nov 2025
 09:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104003536.3601931-1-rananta@google.com> <20251104003536.3601931-5-rananta@google.com>
 <aQvzNZU9x9gmFzH3@google.com>
In-Reply-To: <aQvzNZU9x9gmFzH3@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 6 Nov 2025 22:35:15 +0530
X-Gm-Features: AWmQ_blPZrkpBvmyDjz4m59o85g-W_MDdRSUVfgEkRTnXJ6AKrfvsBTKM_KJmiQ
Message-ID: <CAJHc60ycPfeba0hjiHLTgFO2JAjPsuWzHhJqVbqOTEaOPfNy_A@mail.gmail.com>
Subject: Re: [PATCH 4/4] vfio: selftests: Add tests to validate SR-IOV UAPI
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 6:30=E2=80=AFAM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
>
> > +static const char *pf_dev_bdf;
> > +static char vf_dev_bdf[16];
>
> vf_dev_bdf can be part of the test fixture instead of a global variable.
> pf_dev_bdf should be the only global variable since we have to get it
> from main() into the text fixture.
>
My understading is placing vars in FIXTURE() is helpful to get an
access across various other FIXTURE_*() and TEST*() functions. Out of
curiosity, is there an advantage here vs having them global?

> > +
> > +struct vfio_pci_device *pf_device;
> > +struct vfio_pci_device *vf_device;
>
> These can be local variables in the places they are used.
>
I was a bit greedy to save a few lines, as they are reassigned in
every TEST_F() anyway. Is there any advantage by making them local?

> > +
> > +static void test_vfio_pci_container_setup(struct vfio_pci_device *devi=
ce,
> > +                                        const char *bdf,
> > +                                        const char *vf_token)
> > +{
> > +     vfio_container_open(device);
> > +     vfio_pci_group_setup(device, bdf);
> > +     vfio_container_set_iommu(device);
> > +     __vfio_container_get_device_fd(device, bdf, vf_token);
> > +}
> > +
> > +static int test_vfio_pci_iommufd_setup(struct vfio_pci_device *device,
> > +                                     const char *bdf, const char *vf_t=
oken)
> > +{
> > +     vfio_pci_iommufd_cdev_open(device, bdf);
> > +     vfio_pci_iommufd_iommudev_open(device);
> > +     return __vfio_device_bind_iommufd(device->fd, device->iommufd, vf=
_token);
> > +}
> > +
> > +static struct vfio_pci_device *test_vfio_pci_device_init(const char *b=
df,
> > +                                                       const char *iom=
mu_mode,
> > +                                                       const char *vf_=
token,
> > +                                                       int *out_ret)
> > +{
> > +     struct vfio_pci_device *device;
> > +
> > +     device =3D calloc(1, sizeof(*device));
> > +     VFIO_ASSERT_NOT_NULL(device);
> > +
> > +     device->iommu_mode =3D lookup_iommu_mode(iommu_mode);
> > +
> > +     if (iommu_mode_container_path(iommu_mode)) {
> > +             test_vfio_pci_container_setup(device, bdf, vf_token);
> > +             /* The device fd will be -1 in case of mismatched tokens =
*/
> > +             *out_ret =3D (device->fd < 0);
>
> Maybe just return device->fd from test_vfio_pci_container_setup() so
> this can be:
>
>   *out_ret =3D test_vfio_pci_container_setup(device, bdf, vf_token);
>
> and then you can drop the curly braces.
>
Makes sense. I'll do it in v2.

> > +     } else {
> > +             *out_ret =3D test_vfio_pci_iommufd_setup(device, bdf, vf_=
token);
> > +     }
> > +
> > +     return device;
> > +}
> > +
> > +static void test_vfio_pci_device_cleanup(struct vfio_pci_device *devic=
e)
> > +{
> > +     if (device->fd > 0)
> > +             VFIO_ASSERT_EQ(close(device->fd), 0);
> > +
> > +     if (device->iommufd) {
> > +             VFIO_ASSERT_EQ(close(device->iommufd), 0);
> > +     } else {
> > +             VFIO_ASSERT_EQ(close(device->group_fd), 0);
> > +             VFIO_ASSERT_EQ(close(device->container_fd), 0);
> > +     }
> > +
> > +     free(device);
> > +}
> > +
> > +FIXTURE(vfio_pci_sriov_uapi_test) {};
> > +
> > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > +{
> > +     char vf_path[PATH_MAX] =3D {0};
> > +     char path[PATH_MAX] =3D {0};
> > +     unsigned int nr_vfs;
> > +     char buf[32] =3D {0};
> > +     int ret;
> > +     int fd;
> > +
> > +     /* Check if SR-IOV is supported by the device */
> > +     snprintf(path, PATH_MAX, "%s/%s/sriov_totalvfs", PCI_SYSFS_PATH, =
pf_dev_bdf);
>
> nit: Personally I would just hard-code the sysfs path instead of using
> PCI_SYSFS_PATH. I think the code is more readable and more succinct that
> way. And sysfs should be a stable ABI.
>
Sure.

> > +     fd =3D open(path, O_RDONLY);
> > +     if (fd < 0) {
> > +             fprintf(stderr, "SR-IOV may not be supported by the devic=
e\n");
> > +             exit(KSFT_SKIP);
>
> Use SKIP() for this:
>
Sure.
> if (fd < 0)
>         SKIP(return, "SR-IOV is not supported by the device\n");
>
> Ditto below.
>
> > +     }
> > +
> > +     ASSERT_GT(read(fd, buf, ARRAY_SIZE(buf)), 0);
> > +     ASSERT_EQ(close(fd), 0);
> > +     nr_vfs =3D strtoul(buf, NULL, 0);
> > +     if (nr_vfs < 0) {
> > +             fprintf(stderr, "SR-IOV may not be supported by the devic=
e\n");
> > +             exit(KSFT_SKIP);
> > +     }
> > +
> > +     /* Setup VFs, if already not done */
>
> Before creating VFs, should we disable auto-probing so the VFs don't get
> bound to some other random driver (write 0 to sriov_drivers_autoprobe)?
>
Good idea. I'll make this change in v2.

> > +     snprintf(path, PATH_MAX, "%s/%s/sriov_numvfs", PCI_SYSFS_PATH, pf=
_dev_bdf);
> > +     ASSERT_GT(fd =3D open(path, O_RDWR), 0);
> > +     ASSERT_GT(read(fd, buf, ARRAY_SIZE(buf)), 0);
> > +     nr_vfs =3D strtoul(buf, NULL, 0);
> > +     if (nr_vfs =3D=3D 0)
>
> If VFs are already enabled, shouldn't the test fail or skip?
>
My idea was to simply "steal" the device that was already created and
use it. Do we want to skip it, as you suggested?

> > +             ASSERT_EQ(write(fd, "1", 1), 1);
> > +     ASSERT_EQ(close(fd), 0);
> > +
> > +     /* Get the BDF of the first VF */
> > +     snprintf(path, PATH_MAX, "%s/%s/virtfn0", PCI_SYSFS_PATH, pf_dev_=
bdf);
> > +     ret =3D readlink(path, vf_path, PATH_MAX);
> > +     ASSERT_NE(ret, -1);
> > +     ret =3D sscanf(basename(vf_path), "%s", vf_dev_bdf);
> > +     ASSERT_EQ(ret, 1);
>
> What ensures the created VF is bound to vfio-pci?
>
Good point. I'll explicitly bind it to vfio-pci, if it isn't already.

> > +}
> > +
> > +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> > +{
> > +}
>
> FIXTURE_TEARDOWN() should undo what FIXTURE_SETUP() did, i.e. write 0 to
> sriov_numvfs. Otherwise running this test will leave behind SR-IOV
> enabled on the PF.
>
I had this originally, but then realized that run.sh aready resets the
sriov_numvfs to its original value. We can do it here too, if you'd
like to keep the symmetry and make the test self-sufficient. With some
of your other suggestions, I may have to do some more cleanup here
now.

> You could also make this the users problem (the user has to provide a PF
> with 1 VF where both PF and VF are bound to vfio-pci). But I think it
> would be nice to make the test work automatically given a PF if we can.
Let's go with the latter, assuming it doesn't get too complicated
(currently, the setup part seems bigger than the actual test :) )

