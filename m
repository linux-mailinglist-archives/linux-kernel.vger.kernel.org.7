Return-Path: <linux-kernel+bounces-863814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E3BF92BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE9B40763D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6258E28506A;
	Tue, 21 Oct 2025 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iImPtcj0"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331915CD74
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761087813; cv=none; b=Q6F2sUtotvqPkmG+ur3gF6rqMabFw3fYYBhnzeYbm2Ps50GoXGrZlH07uUz+H+Alv4l3Pa/LhqGvEB0qhu+bdko/jCuPZoagFwCXVHf0GzwXmFVZiZ7nyPif6IzImPf6mgLfo0Bb44DxGPmxMmQOiP+te259LXk2H4dl2vV9zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761087813; c=relaxed/simple;
	bh=DFKz/0QWxrsnlFZ7ppZ/92x0zP8vpqycj+ZZCk0JVFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvgiC7nybymgmeeWst8zyNeel5iasyyRZyRPjVvmFoRanu/W3hqYzZwNlLmYKIHESu3TPQAj4CaWYOK0dFfbYqX/Panj47Wy+aQ7416dojinF0yc8LBQ2YuB4gDKg7kVbbVakzdlzcQ50TSFWQwf/I6dEAy4xykBQ+kbV3h77wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iImPtcj0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c1877b428so112257226d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761087810; x=1761692610; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5Bh5O0u2edCj6s7JQTYVPlxSEp6IH0+GcP0uyaYNtA=;
        b=iImPtcj0eybBvZ/x2BauvvI4coi2dawMepCA7Qmmwva2BKkQz2xNHfIxiBTfYtcIAv
         LZ8xn0DXTLEYUz1j+USdjVwXOTGUz368xRNEof/TsUj57S5pl7Fuyc3/mcazgHEcBA/f
         ySv1y8bIXa6U9ZJvZvtF8RLID3+xaRt5JIly2Ip09EGWgxG0d8yOqdiAdJzB7qziSV0M
         Aavoa+CSYpr6ZzK5CM7m/Wd1dXL55wkA8L8jpAE1cWImj3j8Zxfr8JymazJhkU5ClzLm
         oLKnfgtw2aX8374zmaj1/Smp50xgWLIQqiRRKkT+OmWoDvCIiNC4qDYULspd1o68fFrX
         GZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761087810; x=1761692610;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5Bh5O0u2edCj6s7JQTYVPlxSEp6IH0+GcP0uyaYNtA=;
        b=No7FkI76ajT9Rg/y2eH99WJgtKYF7SD7hvoHyIWHIMBP7M8WHjs2shZbhd4MlIO4Ag
         VihgYZUZt0mnbwZksgace2/LoVDhXnv66y004bLWTyIIE2UdJE7Upb2/S/+FJHbJlVl/
         FY3/J8sOildOKBpVBPjBn3N2bHj0nM1fkMfBt5idULlRhmok9Sa4G3VeVybDw93hu4d0
         COkZ7d3+p3mMjBuHjY8mPUwsUi71wbxlippjLxc5jvmY5lj8viYJM85rPlAI2I1QxxU+
         cvR+kOzrRcQ3uNaiPs2xbkWTL4GT7vbZJm8nLqWqoIL0EYv/zhNug64ebHNgGb91svDo
         4sbA==
X-Forwarded-Encrypted: i=1; AJvYcCWp9NlQB/nt26tPpHNheHULnqWNpzbWj8rahMKBnmWlrY8RJ6kQ02Ctq86nOvSv2F7RikUJj3Td4HkibyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6myuDH73ReKHQe/MCK3KpL/q8wS8HTdqXHvKzGhPvh8ep6c2e
	S3Go4KpEjV8N64XKoUkwLwXETKuMVicGLp1JRnfH9SgUq1nWqeq2c2ge6+Qxx//jtOw=
X-Gm-Gg: ASbGncv9rAnGZ4jt/eGc8D1067L0hTiAqJp/K2NpYyJzzxx8nnjVBSy2fEhelUSCQ9g
	Rv4kfQRFV9a5Mh0OR+EfxPDaV6qwZ3z1A4H5gg3XJc3U3UQz831GXMbc4U9fbiqegN5z7sCuCIl
	FTM+WU0/3MWoNm6ZCRHfO2N7capT51fqYV4uPkcTFfzKRTihz0DMV8bwvRzeskUXWlO9v/6cOTJ
	/M/GWJzAreNYVGuN7XwSVlxELWT66F9ixtsl9SrgBk8qE5yf0eeunV4MeQ0tDc02NPKdEUkl4Bi
	ytkECXkaPIsM0ZEA+pHmGmhAp+4nGaiP8CtDMeGrKRswfFYe1e0axmBDOFrMtJMnwaS8e3uBPUU
	mQUivtgn+yyr/zBb31FIBDql8BtHKMmcFJjPwMaU7dpXUQrB0hQL5MckdSNHrLMod+ozSRw+sw7
	YrevAz8IOO9lZNZDGNgYj1X0Ej+XHlHR3E48IiE/GQmOuXdoSF6ZpcnU+z
X-Google-Smtp-Source: AGHT+IF5TEP/imVUZDeqxAFOvJLVSc/DIGvaFM794M9E7hmCaqBWJ7XSxLIfFTPccdLhgqmKXhQMqg==
X-Received: by 2002:a05:6214:1243:b0:87c:1032:e849 with SMTP id 6a1803df08f44-87c2058e3e5mr236812616d6.30.1761087810447;
        Tue, 21 Oct 2025 16:03:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02884878sm76147436d6.31.2025.10.21.16.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:03:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBLO4-00000000NfJ-3RNd;
	Tue, 21 Oct 2025 20:03:28 -0300
Date: Tue, 21 Oct 2025 20:03:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lukasz Laguna <lukasz.laguna@intel.com>
Subject: Re: [PATCH 26/26] vfio/xe: Add vendor-specific vfio_pci driver for
 Intel graphics
Message-ID: <20251021230328.GA21554@ziepe.ca>
References: <20251011193847.1836454-1-michal.winiarski@intel.com>
 <20251011193847.1836454-27-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251011193847.1836454-27-michal.winiarski@intel.com>

On Sat, Oct 11, 2025 at 09:38:47PM +0200, Michał Winiarski wrote:
> +	/*
> +	 * "STOP" handling is reused for "RUNNING_P2P", as the device doesn't have the capability to
> +	 * selectively block p2p DMA transfers.
> +	 * The device is not processing new workload requests when the VF is stopped, and both
> +	 * memory and MMIO communication channels are transferred to destination (where processing
> +	 * will be resumed).
> +	 */
> +	if ((cur == VFIO_DEVICE_STATE_RUNNING && new == VFIO_DEVICE_STATE_STOP) ||
> +	    (cur == VFIO_DEVICE_STATE_RUNNING && new == VFIO_DEVICE_STATE_RUNNING_P2P)) {
> +		ret = xe_sriov_vfio_stop(xe_vdev->pf, xe_vdev->vfid);

This comment is not right, RUNNING_P2P means the device can still
receive P2P activity on it's BAR. Eg a GPU will still allow read/write
to its framebuffer.

But it is not initiating any new transactions.

> +static void xe_vfio_pci_migration_init(struct vfio_device *core_vdev)
> +{
> +	struct xe_vfio_pci_core_device *xe_vdev =
> +		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
> +	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
> +
> +	if (!xe_sriov_vfio_migration_supported(pdev->physfn))
> +		return;
> +
> +	/* vfid starts from 1 for xe */
> +	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
> +	xe_vdev->pf = pdev->physfn;

No, this has to use pci_iov_get_pf_drvdata, and this driver should
never have a naked pf pointer flowing around.

The entire exported interface is wrongly formed:

+bool xe_sriov_vfio_migration_supported(struct pci_dev *pdev);
+int xe_sriov_vfio_wait_flr_done(struct pci_dev *pdev, unsigned int vfid);
+int xe_sriov_vfio_stop(struct pci_dev *pdev, unsigned int vfid);
+int xe_sriov_vfio_run(struct pci_dev *pdev, unsigned int vfid);
+int xe_sriov_vfio_stop_copy_enter(struct pci_dev *pdev, unsigned int vfid);

None of these should be taking in a naked pci_dev, it should all work
on whatever type the drvdata is.

And this gross thing needs to go away too:

> +       if (pdev->is_virtfn && strcmp(pdev->physfn->dev.driver->name, "xe") == 0)
> +               xe_vfio_pci_migration_init(core_vdev);

Jason

