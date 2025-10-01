Return-Path: <linux-kernel+bounces-839260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B4BB131C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2A4177BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A9A28643B;
	Wed,  1 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="krwbO1u4"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B0286892
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334336; cv=none; b=AvHMELc948fIkkoHh1eoqDoGlHp7LS37NSVP6jRCl6gXjhQ1UtMGUI+9GAtJKPVXU4kBeDlf+VVDFBRTZUhIncmMzm7Esjsc6bpgnSbYGzaV5pcHHwZ7Y+9NJ7CpCDcG8pV2YtrWyBrxOUBnmLRQ9kAPfi+Km7l64/LxB5mgk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334336; c=relaxed/simple;
	bh=pdz8Fuw7xeerW7PMZ/xqhVUHiIjhMYLhhkVWLjrs8Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/TK9Zr0Zk/FLxmP71Oetw/AFdJNtXaXduidIds2ZEz8oqLK6srJfndr3OqlBIuYVNbWqq8XWtzAKendkSlSXODqXZWNF1GWS99cnigpDrIy4ZQeX688ClY46Tt5bKqFK9YKwlDcLPval946V2b3VAJusOO47J9BypXvgSKmPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=krwbO1u4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso78102b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759334333; x=1759939133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4HyuyQkoHBvYzsGa6aoQI9vTUKAsw5OI/i9bKDk1gM=;
        b=krwbO1u43rIFkIF+wAE6h+qkS0pIqRZ/ipSg0DEUJhzwoKFFcpT7u803rmAATI2PDn
         orvBazafoRJiXx0g2N7HEXBvzYbH5oMnuvv5JCBkh5j1LwDOOXcgk1AFHSaAkM6Jf7p+
         dNPjpuPzsoiDAdcdHd4sO9pFfBFabZuebv+fKkS2NnxvS0ZTLYq3TuojLpaW7HPBuS7f
         4lYeK13Rmj/wQs87xE1XOE4Dhups74rJcUiTTjJOyV04UNfTDlsIRckSIt7zi950uqzx
         oKUXR+ImmnH3Avyg6uP1R7Th/YjMcrkQgNNHtH93jtqlkZRSq2zIjX6SJ7I/gOjHxiYX
         aDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334333; x=1759939133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4HyuyQkoHBvYzsGa6aoQI9vTUKAsw5OI/i9bKDk1gM=;
        b=OwsZAcc1PUMZ7t9JvuKw/Q/2Mo2H8KmPwmrj3bwxFpn7uvje1zSFRlj2iDGo7d+KGZ
         FTTXGlQaGDz+hN6ysfeBN+DGMsh4WbTPgkDqsw0Zb+ZM+nsisD2qlKTjBbyhn4lNOS89
         YbNrRqQ5mlUjZmUVew0quw0LQYA1c8Q4ci/vnA9vLM5p/VPIp6v0V++pAehrdgcG8rjH
         C1BZX42TYSY4o4Vrkb73nm6VG2z8qnpE+7MKSC1tX6NIdKg5RScwAU5NJbk43MzP8xst
         SM1bfwdUmzp63tJHF44M0Btcaj44OzFA75NPn2XeqfO/5Pkngvg8t7CFMqzGo/+xJHyI
         jx1A==
X-Forwarded-Encrypted: i=1; AJvYcCUC6IoEXxxOuASnwLSaqGWQhv8pkBAXYOkOQP4KgQ1MhVeB0P6pt5J2cQOenvGnP6Qx98nK75RYl79reTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuq4fyk8zeZBZMwajjzgXxluHA8Xnfbarb+ComXfan8toHDxrF
	gdTh/CErigkUBA7tlrXLceENHLa9uPeEBOq6qUuWj7GbL8Ev78pn7moMhKL+Q04i6A0=
X-Gm-Gg: ASbGncta/TZRUWn/Tv1ImcT3uZuTymRx2ee6Wa3Qfa+quWWSlEsUqStLGidXKfq+tSH
	2ft7PIa/QYvjB+jNg309ZI1PqlfMk1T82YYJMQnsB5h6rV2xbFIBAFejoXiwnEehyatIdMqDmsQ
	9rcdjmXfA1PHo/0o+rK/aTIGJaOYTa8CArcxz5s7BNhSoUFZ1gF4AtfZAFUM1C38fzuEe2Y1hdL
	ofsZXasIF+brcHov3XQln8iJk/n/CuBr6D8N3s0cHzmCuM3lEH8M9ViaK8QW30YsVUr8N1HVS4J
	6AHduorY7+B2MQteAFi32BeHInYo3esYoSxhkVLFbr+HpSdM6iAW1zbHIfzFcalIdZDFkFAP7le
	X8t7XW0bdSCW0WjWlA8OQ9mKGdNnPXo4=
X-Google-Smtp-Source: AGHT+IG9UPo6cxHRJt4pSeinOZAd23m8t66DoVx2m4sPdAYJV7/Vd4Ao/dqW0fHs4d80dy+cLnFnxg==
X-Received: by 2002:a05:6a20:3946:b0:24c:dd96:5500 with SMTP id adf61e73a8af0-321d8452e58mr4960078637.11.1759334333229;
        Wed, 01 Oct 2025 08:58:53 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537ebsm90602b3a.47.2025.10.01.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:58:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3zEB-0000000D4OH-1Yy4;
	Wed, 01 Oct 2025 12:58:51 -0300
Date: Wed, 1 Oct 2025 12:58:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <20251001155851.GW2695987@ziepe.ca>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
 <0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com>

On Tue, Sep 30, 2025 at 08:35:01PM +0100, Robin Murphy wrote:
> On 2025-09-30 7:21 pm, Jason Gunthorpe wrote:
> > On Thu, Sep 25, 2025 at 02:27:42PM +0200, Johan Hovold wrote:
> > > This series fixes device leaks in the iommu drivers, which pretty
> > > consistently failed to drop the reference taken by
> > > of_find_device_by_node() when looking up iommu platform devices.
> > 
> > Yes, they are mis-designed in many ways :\
> 
> Historically they weren't really leaks either, just spare references on a
> device which at that point could definitely never go away. I suppose now
> that we finally have the .of_xlate calls in IOMMU registration, it would be
> possible for some error during probe to cause the IOMMU driver to fail to
> bind, at which point the references could rightly be considered leaked,
> however these are all embedded platforms with essentially zero chance of
> platform device hotplug, especially not of IOMMU devices, so realistically
> those references still don't matter to anything other than code checkers.
> 
> In summary; meh.

Yeah, it isn't a real practical bug, but it still ugly and no doubt
upsets static tools.

> > IDK if it is worth fixing like this, or if more effort should be put
> > to make the drivers use of_xlate properly - the arm smmu drivers show
> > the only way to use it..
> 
> The SMMU drivers are really doing the same thing, they just defer that
> lookup operation to .probe_device time (largely for historical reasons, I
> think), and they use bus_find_device_by_node() 

However the SMMU drivers are doing this under the
iommu_probe_device_lock and not stashing the pointer into a drvdata
where there is no locking protecting it. 

> It's not racy; if we're calling the .of_xlate op (or really any op for that
> matter), it's because an IOMMU driver has registered (or is registering) for
> the given fwnode, which means it is bound to the corresponding struct
> device.

It is not racy if you make the very practical assumption there is no
iommu driver unplug.

Anyhow, I drafted a nice fix for all of this. After all the rework it
is trivial for the core code to pass in the struct iommu_device * to
probe and then most of the drivers just drop this ugly code
completely.

https://github.com/jgunthorpe/linux/commits/iommu-fwspec/

Jason

commit cca42a9b5325b96bfd3d74e24628511f537afbe9
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Wed Oct 1 09:18:13 2025 -0300

    iommu: Add a probe_device_fwspec() op
    
    For fwspec using drivers the core code has already determined which struct
    iommu_device instance the fwspec is linked to. It can trivially pass that
    instance pointer into the driver.
    
    This frees fwspec drivers from having to repeat the work of trying to find
    the struct iommu_device for the fwspec.
    
    Non-fwspec drivers (x86/etc) continue to use the old probe function which
    is called on the first non-fwspec iommu driver registered.
    
    This is only usable by drivers that support a single iommu instance per
    device. There are some drivers (msm, exynos, dart) that do have an iommus
    property that list multiple iommu_devices with multiple IDs. They cannot
    use this simplified mechanism.
    
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee163..718a1da8f54710 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -142,6 +142,8 @@ static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev);
 static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
 			      const struct iommu_ops *ops);
+static struct iommu_device *
+iommu_from_fwnode(const struct fwnode_handle *fwnode);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -406,13 +408,75 @@ void dev_iommu_priv_set(struct device *dev, void *priv)
 }
 EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
 
+static int iommu_do_probe_device(struct device *dev)
+{
+	struct iommu_device *iommu;
+	int ret;
+
+	lockdep_assert_held(&iommu_probe_device_lock);
+
+	if (dev->iommu->fwspec) {
+		struct iommu_device *fwspec_iommu;
+
+		fwspec_iommu =
+			iommu_from_fwnode(dev->iommu->fwspec->iommu_fwnode);
+		if (!fwspec_iommu)
+			return -ENODEV;
+
+		if (fwspec_iommu->ops->probe_device_fwspec) {
+			ret = fwspec_iommu->ops->probe_device_fwspec(
+				fwspec_iommu, dev);
+			if (ret)
+				return ret;
+			iommu = fwspec_iommu;
+		} else {
+			iommu = fwspec_iommu->ops->probe_device(dev);
+			if (IS_ERR(iommu))
+				return PTR_ERR(iommu);
+			if (WARN_ON(iommu != fwspec_iommu)) {
+				ret = -EINVAL;
+				goto err_release;
+			}
+		}
+	} else {
+		/*
+		 * At this point, relevant devices either now have a fwspec
+		 * which will match ops registered with a non-NULL fwnode, or we
+		 * can reasonably assume that only one of Intel, AMD, s390, PAMU
+		 * or legacy SMMUv2 can be present, and that any of their
+		 * registered instances has suitable ops for probing, and thus
+		 * cheekily co-opt the same mechanism.
+		 */
+		iommu = iommu_from_fwnode(NULL);
+		if (!iommu)
+			return -ENODEV;
+		/* Non fwspec drivers must identify their instance internally */
+		if (WARN_ON(!iommu->ops->probe_device))
+			return -EINVAL;
+		iommu = iommu->ops->probe_device(dev);
+		if (IS_ERR(iommu))
+			return PTR_ERR(iommu);
+	}
+
+	if (!try_module_get(iommu->ops->owner)) {
+		ret = -EINVAL;
+		goto err_release;
+	}
+
+	dev->iommu->iommu_dev = iommu;
+
+err_release:
+	if (iommu->ops->release_device)
+		iommu->ops->release_device(dev);
+	return ret;
+}
+
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed
  */
 static int iommu_init_device(struct device *dev)
 {
-	const struct iommu_ops *ops;
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	int ret;
@@ -434,36 +498,17 @@ static int iommu_init_device(struct device *dev)
 		if (!dev->iommu || dev->iommu_group)
 			return -ENODEV;
 	}
-	/*
-	 * At this point, relevant devices either now have a fwspec which will
-	 * match ops registered with a non-NULL fwnode, or we can reasonably
-	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
-	 * be present, and that any of their registered instances has suitable
-	 * ops for probing, and thus cheekily co-opt the same mechanism.
-	 */
-	ops = iommu_fwspec_ops(dev->iommu->fwspec);
-	if (!ops) {
-		ret = -ENODEV;
-		goto err_free;
-	}
 
-	if (!try_module_get(ops->owner)) {
-		ret = -EINVAL;
+	ret = iommu_do_probe_device(dev);
+	if (ret)
 		goto err_free;
-	}
-
-	iommu_dev = ops->probe_device(dev);
-	if (IS_ERR(iommu_dev)) {
-		ret = PTR_ERR(iommu_dev);
-		goto err_module_put;
-	}
-	dev->iommu->iommu_dev = iommu_dev;
+	iommu_dev = dev->iommu->iommu_dev;
 
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
 		goto err_release;
 
-	group = ops->device_group(dev);
+	group = iommu_dev->ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		group = ERR_PTR(-EINVAL);
 	if (IS_ERR(group)) {
@@ -473,17 +518,17 @@ static int iommu_init_device(struct device *dev)
 	dev->iommu_group = group;
 
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
-	if (ops->is_attach_deferred)
-		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
+	if (iommu_dev->ops->is_attach_deferred)
+		dev->iommu->attach_deferred =
+			iommu_dev->ops->is_attach_deferred(dev);
 	return 0;
 
 err_unlink:
 	iommu_device_unlink(iommu_dev, dev);
 err_release:
-	if (ops->release_device)
-		ops->release_device(dev);
-err_module_put:
-	module_put(ops->owner);
+	if (iommu_dev->ops->release_device)
+		iommu_dev->ops->release_device(dev);
+	module_put(iommu_dev->ops->owner);
 err_free:
 	dev->iommu->iommu_dev = NULL;
 	dev_iommu_free(dev);
@@ -2855,9 +2900,10 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-static const struct iommu_device *iommu_from_fwnode(const struct fwnode_handle *fwnode)
+static struct iommu_device *iommu_from_fwnode(
+	const struct fwnode_handle *fwnode)
 {
-	const struct iommu_device *iommu, *ret = NULL;
+	struct iommu_device *iommu, *ret = NULL;
 
 	spin_lock(&iommu_device_lock);
 	list_for_each_entry(iommu, &iommu_device_list, list)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473df..52e74ccdb4dc79 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -48,6 +48,7 @@ struct iommufd_ctx;
 struct iommufd_viommu;
 struct msi_desc;
 struct msi_msg;
+struct iommu_device;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -680,6 +681,8 @@ struct iommu_ops {
 		struct device *dev, struct iommu_domain *parent, u32 flags,
 		const struct iommu_user_data *user_data);
 
+	int (*probe_device_fwspec)(struct iommu_device *iommu,
+				   struct device *dev);
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);

