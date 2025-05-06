Return-Path: <linux-kernel+bounces-636205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0D5AAC7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4FC4C85CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E82281516;
	Tue,  6 May 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjKpFh6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783331E3DF4;
	Tue,  6 May 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541198; cv=none; b=JD/gJ77kzVf8lsc8BVRIxrdL9uMeSn0z6JxidHRNuWj0IJXo3gsxEi8UMHEogn3erxLQCtnGcXgjbluOQz+0bHLEQ9i/PpcPPok4VUFvrZx44Rm6yUncpQFtNMVIFqh8vMgAY+XyjbpCYBzn+gOnVqiWRwyWKDo6Oduo/WS5p3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541198; c=relaxed/simple;
	bh=mTMRUMgR4L/7RvmPvU/2UmZ78JGiv9EeVU2GVr4rwT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8xtaNeq0hUNkEtMRDzdqf/bhQGkwf9rniTGWDxdzdAVS7Cxpe5+PrIbbO/UmsI0U1VDoEzvJ765BclxBllAdkDclQnx5OnNuS23yyOuVmoE8iOuTWWt9R1aT9WRo2FXQQ6H+Kx+CBfcBWWTuJ+Oi2PCj4RtfDoQCQLpeDXhrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjKpFh6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1F0C4CEE4;
	Tue,  6 May 2025 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746541197;
	bh=mTMRUMgR4L/7RvmPvU/2UmZ78JGiv9EeVU2GVr4rwT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjKpFh6x+eNnuikWStC2X+QGu1Fl0efOWw++cCFWdpDStaJJsRlBxvrhHbsLt8th+
	 YkqLKUIUVSIzYYURi0ngt9sUpNErDhsod0lN+41Z1wNjdrT6fI/2PH9i/5S6nLjKn4
	 KHB0jCRiniVTa6PqaSFdT16ATwKV51S47DKjDRc8v8YLEWT4U+RpaIivsw4NxDlEMB
	 onLFp4YsRE7SJfcz2zs/JY6b9IEvpUqOgEkiMeykztAJ48sM60fZ9v6Um2lXAcnm1T
	 Nl74zX5JyeBVL1E0HnrCQVL8L2e3iWHfnNRZ26cMEMM1bAfrveFOSulD96tWCGnfuh
	 i0bnNYruJw3Hg==
Date: Tue, 6 May 2025 15:19:49 +0100
From: Will Deacon <will@kernel.org>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	paulmck@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
	maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
	oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
	ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	kevin.tian@intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [RESEND PATCH v6 2/3] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250506141949.GA1197@willie-the-truck>
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-6-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250428153514.55772-6-miko.lenczewski@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 28, 2025 at 03:35:16PM +0000, Mikołaj Lenczewski wrote:
> For supporting BBM Level 2 for userspace mappings, we want to ensure
> that the smmu also supports its own version of BBM Level 2. Luckily, the
> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
> BBM level 2 is claimed.
> 
> Add the feature and testing for it under arm_smmu_sva_supported().
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
>  3 files changed, 10 insertions(+)

This looks fine to me but please note that it doesn't apply against
mainline (v6.15-rc5).

Will

