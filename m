Return-Path: <linux-kernel+bounces-898269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80059C54B81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E67E3AD757
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5C2E229C;
	Wed, 12 Nov 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AbZqB6Hu"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D8207A32
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986957; cv=none; b=FHuycLgLdOHuWSUoa6kQFVOPkqLOEgyMDcoUps/beji2Pf/EU5szXTRvp0HS3uvCkh+9oARCLcJ4LbKrtjIicZgkROCStwB34A9AsN/URYVTQT3kDzC9bRZf2WbWtL1ebAh7BEfPvqw+ib44XgA2WBJ2qALU6Sp3yRxYE1CJA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986957; c=relaxed/simple;
	bh=QrFgy8kef1RTClQoguANzsfanj0qLkO8wMzPB/Oop2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J23H5hlUvcm18qEkweYn+LiOXtv+wQD8ZuZbTkC8/1uH6YySY3H9R/9ZaaujH0MjcWVJWuJP8Hv6iNn4UD4dSuhzWrkDRN5rUPHLyOEH7CdOMfw5JcBKz/icszauqcukc5TT6mfq/wpqGZsAzyy/M4rYzwMhfaGUYF5Z3LJ7yok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AbZqB6Hu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b21fc25ae1so20456785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762986953; x=1763591753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SCRb0goywJQgJBdSKI77dEqVkqf5FzF9n7s1+P7Ecw=;
        b=AbZqB6HuGm6VuqZWbnMFo/gc7+e1z8j46rYYfZuqembi3g8lx0MCXFAroH8IK3EixH
         G0M5989MKnYeK5TF+o8edaBel/6iivfivkL5Yuv3+NxnxxuiB3khfBXMtIk3n0HL5u5L
         VMmyW1G5vmeGTIPnNJnpRQqJYDunYBy6z+uWG+bptPz+HnNPSoqFLq0yFR00wBUA8T9/
         8yeuVyUNbp5U7RdNpVXmclhUOv9tDS8gb/G40msmnLdDOv0lRkkoPfM0UI6k1MWPjiEL
         V8pjKk3ZAVx4tNC+r+HXpAX37KjwCYZC3xuHiRUOlYh5CoEwHXKxO3j2CzyZEP3/PjDD
         m97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762986953; x=1763591753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SCRb0goywJQgJBdSKI77dEqVkqf5FzF9n7s1+P7Ecw=;
        b=ayrti5svue7oZMSK94sgoX7RKuRJfcw+Nj6k5QI2M7mXar4T0ePX7N9E859WCCp0lx
         M6XsYuutendNrRRstlGsNJLrn7gwC6LVzWlSfNd+arkrmDidg1VxVilUY+rhrpUHfivF
         3p7BT8f/6/VgY3zqQ/rJSm2l6FDa/Ds5smZJa9hvJxDE9CbbE5de46bl/zcw2hrj60lR
         KSp7N8L0CRC/QdZWBVMil/c4sFltHVvIYo7+2enD1FT56X9EmoRgzhrkvmgu5CyP8C87
         vy2VMkbwQLJKQ0bYUgSdGRTJ0NH1ifzIckk8sFdNhpORN7g6r2R/I8dZJ654Lh6LmY+G
         Ubkg==
X-Forwarded-Encrypted: i=1; AJvYcCWdrEA+XrYXfBUTCZ3GKp5cHN6bh6rhJK4Z6R+ZKMquYQdzXKv+mUJvAysgChcQTvSRisI5V+s/o2JkNOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8Iz6cxV27Ec92lbCwBOL9aWEmYV7dVd3Y3NOLFSYhUfBMUL6
	+6dcDJlTyHPZRVqJnRDdIRrWxTFq/TlAz0vf3yTVnaP/JPC2C1Jg++eDaKCg8HL69/U=
X-Gm-Gg: ASbGncv7bXAbfS/fd5lMnyirrlI3Vc+fNtvRNupVUcaSFhwFGfkGSrakRIIQCm886KS
	MIsI2A2CV3RJZN3vujShU/Rfth3n5yJSNg98Uc479Qd8oyoFnQOSkkVIqBNAqd/Lj0YLBofdoTD
	Iz0Khco7vdD+wMZiyzmwGCfOJEIXdEoo8Vgbqb73+de2SJCVCWUvYKFUnn4e0sdMMEPlzzkup6+
	IoyFymjnAXi73pSP5QfrOr80q7r+k3oI4eJyqkV0BD1Wd3oEn0zir6NC/FDA4BCPDmoxqnipB+Z
	3A7P/vbmgIV3NxFTMgA1MhdjHxKsqjY/8S4gfB7qlYLYHg/JYu8QSRzFgEGVcljRAmQlXzEJEl2
	x2KylG5jPNPD2P7Ser3bUcI+ELZtxntUigb6XZ5Tef5ZnT4ll4z7ViQnWuxH/YvyKDtQhBZCj5o
	LGbzkDsH/PPOl7ejGUBKxykrRgLsdKLswqO7lSfGwQZbOU4RzVc+D/2ov4GXA=
X-Google-Smtp-Source: AGHT+IHWGpmoPeLN99RSRKB2vhWe71CpUl612R6GfVmHX8/+13R+ZA4bwWYytCuQvVanxwsa6ZIqLw==
X-Received: by 2002:a05:620a:1726:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8b29b764a2dmr589563885a.25.1762986953124;
        Wed, 12 Nov 2025 14:35:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aef2f784sm10061485a.38.2025.11.12.14.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:35:52 -0800 (PST)
Date: Wed, 12 Nov 2025 17:35:50 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 1/3] cxl: Simplify cxl_rd_ops allocation and handling
Message-ID: <aRULxsKoSTXZfPqN@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <20251112205105.1271726-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112205105.1271726-2-rrichter@amd.com>

On Wed, Nov 12, 2025 at 09:51:02PM +0100, Robert Richter wrote:
> A root decoder's callback handlers are collected in struct cxl_rd_ops.
> The structure is dynamically allocated, though it contains only a few
> pointers in it. This also requires to check two pointes to check for
> the existance of a callback.
> 
> Simplify the allocation, release and handler check by embedding the
> ops statically in struct cxl_root_decoder.
> 
> Implementation is equivalent to how struct cxl_root_ops handles the
> callbacks.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


