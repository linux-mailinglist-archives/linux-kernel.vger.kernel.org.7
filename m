Return-Path: <linux-kernel+bounces-821600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35BB81B47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D664A4844
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1524501B;
	Wed, 17 Sep 2025 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BKkKav80"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFFF4F1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139276; cv=none; b=sKXswNU8JB4WNxD64ewqSbDeShjgE0YmmIXMUpHmAj6vs81Znny+z2oKFAVcgho44Z85yd3tZPoPmyBFAFVwQP0T5n1nmGhYbb3fxwHTcozNLM8jfQem8xo1qSKzy3N1YyOoYHh08Ai8FwxJBjiW5FELrvm3js1lEMWlh4QfU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139276; c=relaxed/simple;
	bh=TwwaXOK3sonOdIajnBL0Jr8Oe37u/wbGtgw42yeCzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkU/Eh1exQEIOmQY8fZ7IMMS9MdFmlN/rK1uy3rilYtY2M7TK+QWkh2nKr9FqOc7bycmoIbp2V3g93oC666/vHWGYYZ8om8EUIEOOBBruANFF6cgyKFoVWJUKYb4+mjXHcWN1edY2h8OLBoOSV9antp67W9HhZ1JZGllzqCkTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BKkKav80; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-827ec18434aso22577485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758139273; x=1758744073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSxT7numZXGRA2nu3cjzvMRh4LFS1koCPA4vP4KspNs=;
        b=BKkKav808YLordxEe6Lc4guZG8Ho5el8RhhJ9xiuOMUbh86hSRavLZx+qJpBYPYpkJ
         PZ1MY1qoDCFsmDne4cM0bs+nPh3ZFW4jlffyTrV92AP0ByASN4ButAXqCXEsnAaDqj2e
         7z+SfXE/IDKSH8AIv15pO7iuMxvVSmSXoetpPgABlguu0ov2eYZdOcc2WtoP2GIS17x+
         Grz3stSzAeWs3lHJQlTEZiSwUEQxfM4oUUVWTdwTRkWGqEw/xg1xJlxLmS3+Haht/NkJ
         KUc3uZT34t3im3tHIzqpfmhfXmilevr3woIQInXZN6j0EvpE6aCKdH9lltP7TiO4mVln
         F8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139273; x=1758744073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSxT7numZXGRA2nu3cjzvMRh4LFS1koCPA4vP4KspNs=;
        b=sjg/QonORqnz0EJsYcPoqZhNOhrHQmc6J8njttOgoZC32+sFVJUaTZi+e2Xqd+4kgE
         r8D+JvYUKlAycAPXXfi27dzB5uRy0NNr74ydQhi7WrILQcCrGKtxhJTN2Q+5LggCDp16
         JM/Q3ownsyMxcyx5PEmbeDf4iplyu4LmTJPqBmE/FfQ+zow/bLVqtsoBV2ghyIGDIksV
         hJO6hCKHBJyyZ3d2xqnGbu3YpaL3/r2Wc8L5urC1gepaw84EOddIhMR5zvp+1o2LRmjp
         WEi+Bc/8+RWW7wCWl0ltIs4G99jaWespmMD4nK3Sfeng+DlU/Xh5ivd4rNxCy9yvDysq
         u9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlBW1ujHzxAeXnPiDEK9VIz2/f22ZbsvwG2AiyPxKDl/VHVAFV11/F7q7PN7p7eJll6Fz5vQNm3clP+G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrG2Xo5mQLzpCynIaj4oGzXVMzKAbAIG0u2W5Z1FjWkbOBknUM
	faprzwXzWLSZXsegW1woQ0vUTwFC0emIbQrg7PwVwlE5qRmmO1CforjqyAckgcHLIQLo8JAO36t
	bDIMn
X-Gm-Gg: ASbGncve3UFScsSBfKbEk7IkT8CcsW0idejbKdEZL/jXI70Op/WvfL+CwhXdPLoHZEb
	8rK+zP6x/m5eJIZOMu6MQDL7606kY/qeuvoluZBvlmGAJfvIJ5kds5GlPv6w4teOXl3r34ptC3j
	93pYca/YvyIIMdB3n/MewYpTlD/TxrPUn51yiI5z3Dozj5yPHUE8EN+uksB+T57p5agxU/RXX2F
	13BZsVQG/ZPSlBcFkaeMKw8OzqvHs77QbLU/xeXJFpJaf8lSA0cTT/jvtLqicD62kqapvBac+0m
	IVHN25xaWQQnXoAc+5g6HalOrhtqldB+X8rJUUVhgeeeIrMtVHwHk3M4zjS8S20UJpZK7WYyx7x
	FiSr1c5Yn9ZRCo55/R9pHMxvOKvM7ZlFWloiUrecNR4k4V0csy8rvrydhag3E6qF3Msmawx7ew+
	p+iIc=
X-Google-Smtp-Source: AGHT+IEmjqV82SoNp7n42OCyVT8EaETJLcNBPsDQkV8xsdyDLuOPcXo4OKe0j3W+9TCO5MAXSv1UMA==
X-Received: by 2002:a05:620a:28c1:b0:808:bbc:df09 with SMTP id af79cd13be357-83112d88860mr282060585a.56.1758139272982;
        Wed, 17 Sep 2025 13:01:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8362ffbb364sm35793985a.36.2025.09.17.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:01:12 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:01:10 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 03/11] cxl/region: Rename misleading variable name
 @hpa to @range
Message-ID: <aMsThkaVNjiXrYio@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-4-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:05PM +0200, Robert Richter wrote:
> @hpa is actually a @range, rename variables accordingly.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Nothing major to add on naming feedback so otherwise this is fine.

Reviewed-by: Gregory Price <gourry@gourry.net>

