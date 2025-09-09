Return-Path: <linux-kernel+bounces-807993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34FB4ABBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A01718985A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632131E101;
	Tue,  9 Sep 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDWMtW5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0840285071;
	Tue,  9 Sep 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417227; cv=none; b=H4AwYGoaoZBqbDmGJ54ZNbMKZczXYMkhNl1yfDJ/d8qq2D3xJ+9U5ndVyV+ljxF4BQWr+57Lt/gpG/4lEFtwiYZtc4qJYK5bRFPjQo4AJ54vIH3N/Zv4bBEVZpBT38hpJTQ32D7JLY2ekVBfLYFAmWqyPhuvv1SDOji5p92wrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417227; c=relaxed/simple;
	bh=KlBc/FLfWJ60Mnd+Xoq1/937+YN8YpF4GupEf7cemXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I4+MNbJ4e/vs4LUXHqLsgw2eWJG+3H6XCi0Z34hgfJT87NNZngwS7RJBKJaLqr1/LqXY7FESlojUUyVDjy8dVumYD5tSIlnpLbPzsgEZO0C1BnS3DgJFmDIkrC+uh6EJO1RqIPHUfBclBENKyurSryHDSsmV0NgPB3hP0ZdqLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDWMtW5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FBFC4CEF4;
	Tue,  9 Sep 2025 11:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757417227;
	bh=KlBc/FLfWJ60Mnd+Xoq1/937+YN8YpF4GupEf7cemXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hDWMtW5vK0RsQR8w+ZBzz3DyHkSKsRPSO909jJQcQBc38u5RPxYKorg5QL3MZ99C1
	 UCPeDEMnMBBZ2ht63eiMFXG+iGKQbFJ2lxGanfZ8ALZQN7feDUEfsUaftOetta4Iv3
	 1EHY67CfnlNxcAwSWzQS/53fk/XtNi4KlcaNSgRSjf55i/nU7dpOUn+DEmox/baUni
	 R9J56PQAFkXDolYsFpQaUNM9BBdGFbF2r9cLcDJLNubk+3Oq+aioIs0KaEKaqSIewu
	 EEVNC+6RNpkA2vcxAjZDeOnS8eR0K8/whBu3obvVKKdkn0uQ4MN+GW/blIXtYOc3RN
	 Tf8fEhx+QLVQw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Rahul Kumar <rk0006818@gmail.com>
Cc: miquel.raynal@bootlin.com,  richard@nod.at,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-kernel-mentees@lists.linux.dev,  skhan@linuxfoundation.org,
  Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH v2] mtd: sm_ftl: replace strncpy with memcpy
In-Reply-To: <20250908070124.2647038-1-rk0006818@gmail.com>
References: <20250908070124.2647038-1-rk0006818@gmail.com>
Date: Tue, 09 Sep 2025 13:27:04 +0200
Message-ID: <mafs0cy7zn9x3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Rahul,

On Mon, Sep 08 2025, Rahul Kumar wrote:

> Replace strncpy with memcpy in sm_attr_show and explicitly add a NUL
> terminator after the copy. Also update the return value to reflect the
> extra byte written for the terminator. This aligns with current kernel
> best practices as strncpy is deprecated for such use, as explained in
> Documentation/process/deprecated.rst.
>
> No functional change, only cleanup for consistency.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>

A Suggested-by tag indicates that the patch idea was suggested by that
person. In this case, I did not suggest this patch and merely reviewed
it. So a Suggested-by is slightly odd here. You can read more about the
tags here:
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

[...]

-- 
Regards,
Pratyush Yadav

