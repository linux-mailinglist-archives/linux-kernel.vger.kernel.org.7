Return-Path: <linux-kernel+bounces-720392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC80EAFBB0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F72426573
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B5266582;
	Mon,  7 Jul 2025 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfNPh7c9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED9265CCB;
	Mon,  7 Jul 2025 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913896; cv=none; b=Af0yXZ1NYpKTE58SMPTBaoXA0dqeCGWxgatuzUhY83WJEU5F4Q1Tm2skoa2rVzjgta9/JoaOET+ci1R4QU9nQQeF3gNHZ0gJmereELKbc5JDFsQpczCwnpWWBMMCU96IqJSuMyGSUuD2aAon4bh8CIQ9UetbMPLZotDKeCwqQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913896; c=relaxed/simple;
	bh=IEs4sSynAoScWDVRSCa0ozaZpBNNh2MVii6T5gbzRTk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QG6zyKHVA8fdd2amrSx9EQ8ymntxm+yNlfsc7YwUbfbCF5Xbc/LZcFw6crl3wLhF/e2YzKzxH7wOlSkF+EejTmAZe+6qbomwwnVZSwpCgQiqPorul9/V8+gAbd+cFcdUwc0ABBb/2WHXRttKZRnMTuSZzww4PLL89iLRycAq5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfNPh7c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC67C4CEF8;
	Mon,  7 Jul 2025 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751913895;
	bh=IEs4sSynAoScWDVRSCa0ozaZpBNNh2MVii6T5gbzRTk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cfNPh7c9YgEHCn2RNd3HvFOYnaxMXXqwoTkbnAJn2FrL5v4RnpLcP8Itb6ghE2DE5
	 57lZEWlCnDngTsy4sM97ghVKBgcRKosVRrAg60UE5KQ0iZfzg2GENU7/bRYicgOQV3
	 SCJFHJY+qYyRmO6xKJPxLBLZTxnxucTEVPCsb2BwtDPOBPz8TeydcRAjWdMtk8rQLr
	 QWzSqoSvNMSdymEiEuei7PJtUTcuL3M9VReqmrQs+ZHmYM2xhNLB5DmLY2hyEopvWQ
	 A+ox+XQqcJK5xp/91eTFzcIr9hEA0ml0TvMrY1T8tKlWVOtvkDD67Jh4AVm8Bvf8PO
	 zvEliEp+cqPew==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 20:44:49 +0200
Message-Id: <DB61N61AKIJ3.FG7GUJBG386P@kernel.org>
Subject: Re: [PATCH v4 3/7] drm/gpuvm: Pass map arguments through a struct
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank
 Binns" <frank.binns@imgtec.com>, "Matt Coster" <matt.coster@imgtec.com>,
 "Karol Herbst" <kherbst@redhat.com>, "Lyude Paul" <lyude@redhat.com>,
 "Boris Brezillon" <boris.brezillon@collabora.com>, "Steven Price"
 <steven.price@arm.com>, "Liviu Dudau" <liviu.dudau@arm.com>, "Lucas De
 Marchi" <lucas.demarchi@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <asahi@lists.linux.dev>, "Asahi Lina"
 <lina@asahilina.net>
To: "Caterina Shablia" <caterina.shablia@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
 <20250707170442.1437009-4-caterina.shablia@collabora.com>
In-Reply-To: <20250707170442.1437009-4-caterina.shablia@collabora.com>

On Mon Jul 7, 2025 at 7:04 PM CEST, Caterina Shablia wrote:
> +/**
> + * struct drm_gpuvm_map_req - arguments passed to drm_gpuvm_sm_map[_ops_=
create]()
> + */
> +struct drm_gpuvm_map_req {
> +	/** @va: virtual address related fields */
> +	struct {
> +		/** @va.addr: start of the virtual address range to map to */
> +		u64 addr;
> +
> +		/** @va.size: size of the virtual address range to map to */
> +		u64 range;
> +	} va;
> +
> +	/** @gem: GEM related fields */
> +	struct {
> +		/**
> +		 * @obj: GEM object to map.
> +		 *
> +		 * Can be NULL if the virtual range is not backed by a GEM object.
> +		 */
> +		struct drm_gem_object *obj;
> +
> +		/** @offset: offset in the GEM */
> +		u64 offset;
> +	} gem;
> +};

Can't we just use struct drm_gpuva_op_map instead? The structure is identic=
al
and represents exactly what we want, a map operation.

Let's use that instead of redefining an identical structure.

With that,

	Acked-by: Danilo Krummrich <dakr@kernel.org>

