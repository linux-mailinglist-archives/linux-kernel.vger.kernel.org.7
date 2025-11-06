Return-Path: <linux-kernel+bounces-887581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF06C389CE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3006D34F850
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8B91D432D;
	Thu,  6 Nov 2025 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgqXSInt"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B13823DD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390845; cv=none; b=U1w4lXhnXumDkg0UUoD4FglVs9RheI0k0tIP1kliTpN8ZFK/s7I0aED1doR+DrHy3P9SBuKmKri7XkmbS57eFPRopWRvvbOamQsYvYAHyf8le5v0twxiXxcMPB69AMOI0wBPylfDtDkaMuIwMvWxPXPEEW6hLInWswKsRuyyA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390845; c=relaxed/simple;
	bh=xg+DPaVUx7Y/In8FIB9xUi1KWDGD4s91tBb3OY+DLZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRJOOK7Z6zUScX7Rp/+Sryeh297vJl2d0hjNOBRZuw0W3kM2f+kknMT34UiOpcmNTIpyPBJ+2JGPLgYi0w8gSI/fa7sIt6JbbxpT++o6hty4/Iar6WKlQ3bvufn1QSV1sWOPoAmnpvch3cOen/CYq5WujpVMQa5+69Fyv7UUamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgqXSInt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2956d816c10so5752705ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762390843; x=1762995643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyCdrwmtzeYh65kctndrCh80WL08MrlmZ7q7ncz+eYA=;
        b=JgqXSIntiMnuhw0twoBtcDOfSAqtLr34WjzNgzAxrJTK8iFO1qbWXjW4l9K7FYhLMI
         Rikwt4aTqMubKZyvGhxu3M6uSsKQM9FLkwP7ClLMw2HziTrnjcdRak/FgOcUYqi3Aawl
         UTRi7y20MuK4CqdXpAqkS7VsnUslSnPbYLOtaXV+GekIXGcr88bo8uk/fVbbMhKe51tv
         uD1heVUWWOnnXf+KblvRfXepoht+sNzTTJ/oBjLUaS0TBX5sTg0O6N+4GCidCi3fKtWX
         93je7AvwC0480kXUj2jGgwMSHzbNozrByAFgP6nqdzQqayhk1wPfSddbZuM2Ww51wG8r
         HZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762390843; x=1762995643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyCdrwmtzeYh65kctndrCh80WL08MrlmZ7q7ncz+eYA=;
        b=Pwi6L3KJAXUFOXbL31tYuBAkhHIDIbqdVUPtG3+6Ouvq4Ks01ydP6K10JkIvC1Iw/d
         +Wdg4ssyc6S3WVPtHmQA3Mu8buiha1iqeTgpYMu7xyfEr6WEm3+XU01SjtGL2QsnByyh
         OxS+Fvywe9lkNIvT5+b6RkWvDRQc22gcDVkb5czF9Y3D5YbBud8p53lFW26obzAyhbmi
         PBI8uaKS3hEjCSNbyobmJ5hTa7XXDBkWNmSSVFm46Ow3UFKPSSbcL0CMzfYxddotJZEn
         1MG9omByz4F5mjTDkFBQ0AWxx7LcBMryPXaRdn2SqufFYtTCkcu7tOMA2boGXRGVV+t/
         grSw==
X-Forwarded-Encrypted: i=1; AJvYcCWuFHz9GiaqTrMftUqBs1CvcU+LLlI2hmEItgxywpLAvajBqhjxgSQ0Psa+pgQ4dQ16wieoQfEKi6YuhLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqraoS2neeNFgUSUb0ffEAGKN+m25J0pjq8lqvS4UQQLuuanl
	LbP31Eiqsqdk656pWM0dQ6GPz61qeRKIZtRIv/BIR+6nVRbYg30eIXBx38jPLW1iNw==
X-Gm-Gg: ASbGncsBpNWg/RTaRpaTAMNVy+LYGSrDPMxTxAsXtwiFAi9sNS0yDNWScuWhnvi8wzT
	v1+yA5tYwm/U8xPWFRQOmkF8jAM8q2LSCY9h1i3a+h/igQnrutmHO43mSwEMFSLy5sZqD17l5fx
	tjOeuKGci/F8O9xQinNfj6iSETfss2vRhGjZai5gMALHcgBvCComTQ78DOp0lrNwrY6OYbwZhZD
	Oe5LDLGLeVgtuUx4bHtl9YTOxDxQvOPPTxC9gYHYxXwGmY9RJva4FfNDrEs/3dYeT/dxQZ8kOlY
	0FHSrwjahN3RiLG6zlc/IuVntG+MpQ6NICRRJPGwqTIscKVMFU7SwkYHN5Dmhq7rXy5qPgdmT55
	bGQXDVJSCVq4ArVtfpc2+75JsDUxC5qrLHqbwUwbQIM2dwoFiy20f9OA6PI4/rbz3KNONxJrQ38
	HzL2vCeNNEMu4/XjNSHSwpJR0cxFEuJIceu/v/JkVysPPtkfuCJp03
X-Google-Smtp-Source: AGHT+IHM/szIvc6H/RjXKB2OAGRkV4S9iMOAZRtwQ2X3KKChCXJOhTQKeV++dDoFxAgAZQ81pWgySQ==
X-Received: by 2002:a17:903:244b:b0:295:20b8:e0ef with SMTP id d9443c01a7336-2962add94fdmr64516045ad.57.1762390841917;
        Wed, 05 Nov 2025 17:00:41 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm7911595ad.24.2025.11.05.17.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 17:00:41 -0800 (PST)
Date: Thu, 6 Nov 2025 01:00:37 +0000
From: David Matlack <dmatlack@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] vfio: selftests: Add tests to validate SR-IOV UAPI
Message-ID: <aQvzNZU9x9gmFzH3@google.com>
References: <20251104003536.3601931-1-rananta@google.com>
 <20251104003536.3601931-5-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104003536.3601931-5-rananta@google.com>

On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:

> +static const char *pf_dev_bdf;
> +static char vf_dev_bdf[16];

vf_dev_bdf can be part of the test fixture instead of a global variable.
pf_dev_bdf should be the only global variable since we have to get it
from main() into the text fixture.

> +
> +struct vfio_pci_device *pf_device;
> +struct vfio_pci_device *vf_device;

These can be local variables in the places they are used.

> +
> +static void test_vfio_pci_container_setup(struct vfio_pci_device *device,
> +					   const char *bdf,
> +					   const char *vf_token)
> +{
> +	vfio_container_open(device);
> +	vfio_pci_group_setup(device, bdf);
> +	vfio_container_set_iommu(device);
> +	__vfio_container_get_device_fd(device, bdf, vf_token);
> +}
> +
> +static int test_vfio_pci_iommufd_setup(struct vfio_pci_device *device,
> +					const char *bdf, const char *vf_token)
> +{
> +	vfio_pci_iommufd_cdev_open(device, bdf);
> +	vfio_pci_iommufd_iommudev_open(device);
> +	return __vfio_device_bind_iommufd(device->fd, device->iommufd, vf_token);
> +}
> +
> +static struct vfio_pci_device *test_vfio_pci_device_init(const char *bdf,
> +							  const char *iommu_mode,
> +							  const char *vf_token,
> +							  int *out_ret)
> +{
> +	struct vfio_pci_device *device;
> +
> +	device = calloc(1, sizeof(*device));
> +	VFIO_ASSERT_NOT_NULL(device);
> +
> +	device->iommu_mode = lookup_iommu_mode(iommu_mode);
> +
> +	if (iommu_mode_container_path(iommu_mode)) {
> +		test_vfio_pci_container_setup(device, bdf, vf_token);
> +		/* The device fd will be -1 in case of mismatched tokens */
> +		*out_ret = (device->fd < 0);

Maybe just return device->fd from test_vfio_pci_container_setup() so
this can be:

  *out_ret = test_vfio_pci_container_setup(device, bdf, vf_token);

and then you can drop the curly braces.

> +	} else {
> +		*out_ret = test_vfio_pci_iommufd_setup(device, bdf, vf_token);
> +	}
> +
> +	return device;
> +}
> +
> +static void test_vfio_pci_device_cleanup(struct vfio_pci_device *device)
> +{
> +	if (device->fd > 0)
> +		VFIO_ASSERT_EQ(close(device->fd), 0);
> +
> +	if (device->iommufd) {
> +		VFIO_ASSERT_EQ(close(device->iommufd), 0);
> +	} else {
> +		VFIO_ASSERT_EQ(close(device->group_fd), 0);
> +		VFIO_ASSERT_EQ(close(device->container_fd), 0);
> +	}
> +
> +	free(device);
> +}
> +
> +FIXTURE(vfio_pci_sriov_uapi_test) {};
> +
> +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> +{
> +	char vf_path[PATH_MAX] = {0};
> +	char path[PATH_MAX] = {0};
> +	unsigned int nr_vfs;
> +	char buf[32] = {0};
> +	int ret;
> +	int fd;
> +
> +	/* Check if SR-IOV is supported by the device */
> +	snprintf(path, PATH_MAX, "%s/%s/sriov_totalvfs", PCI_SYSFS_PATH, pf_dev_bdf);

nit: Personally I would just hard-code the sysfs path instead of using
PCI_SYSFS_PATH. I think the code is more readable and more succinct that
way. And sysfs should be a stable ABI.

> +	fd = open(path, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "SR-IOV may not be supported by the device\n");
> +		exit(KSFT_SKIP);

Use SKIP() for this:

if (fd < 0)
        SKIP(return, "SR-IOV is not supported by the device\n");

Ditto below.

> +	}
> +
> +	ASSERT_GT(read(fd, buf, ARRAY_SIZE(buf)), 0);
> +	ASSERT_EQ(close(fd), 0);
> +	nr_vfs = strtoul(buf, NULL, 0);
> +	if (nr_vfs < 0) {
> +		fprintf(stderr, "SR-IOV may not be supported by the device\n");
> +		exit(KSFT_SKIP);
> +	}
> +
> +	/* Setup VFs, if already not done */

Before creating VFs, should we disable auto-probing so the VFs don't get
bound to some other random driver (write 0 to sriov_drivers_autoprobe)?

> +	snprintf(path, PATH_MAX, "%s/%s/sriov_numvfs", PCI_SYSFS_PATH, pf_dev_bdf);
> +	ASSERT_GT(fd = open(path, O_RDWR), 0);
> +	ASSERT_GT(read(fd, buf, ARRAY_SIZE(buf)), 0);
> +	nr_vfs = strtoul(buf, NULL, 0);
> +	if (nr_vfs == 0)

If VFs are already enabled, shouldn't the test fail or skip?

> +		ASSERT_EQ(write(fd, "1", 1), 1);
> +	ASSERT_EQ(close(fd), 0);
> +
> +	/* Get the BDF of the first VF */
> +	snprintf(path, PATH_MAX, "%s/%s/virtfn0", PCI_SYSFS_PATH, pf_dev_bdf);
> +	ret = readlink(path, vf_path, PATH_MAX);
> +	ASSERT_NE(ret, -1);
> +	ret = sscanf(basename(vf_path), "%s", vf_dev_bdf);
> +	ASSERT_EQ(ret, 1);

What ensures the created VF is bound to vfio-pci?

> +}
> +
> +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> +{
> +}

FIXTURE_TEARDOWN() should undo what FIXTURE_SETUP() did, i.e. write 0 to
sriov_numvfs. Otherwise running this test will leave behind SR-IOV
enabled on the PF.

You could also make this the users problem (the user has to provide a PF
with 1 VF where both PF and VF are bound to vfio-pci). But I think it
would be nice to make the test work automatically given a PF if we can.

