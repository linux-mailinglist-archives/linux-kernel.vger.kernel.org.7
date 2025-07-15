Return-Path: <linux-kernel+bounces-731045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFF1B04DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE61AA3CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034252C08CE;
	Tue, 15 Jul 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAWJCr5Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613872CCC5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547228; cv=none; b=lZ+HkGnHiabiY2iQ6zXgmIzOWltdcxHSLLwTyTs/r0t1BWGamPpq1Yosh53STHZ6BZtZECywpsGu/TFX4WOpXABg4dz1xAXtbF8dLb1lGRrByGm15bWu1wpT01F47WQL1zkuwWIlRhheWc1z4dzzmWXPNPpric2cnc/WdCWdwr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547228; c=relaxed/simple;
	bh=zG7a8e7HCQT3UlfAY8UglLJDThyVbih17GkbrYPpo8Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q9CCw43cPPCLr5ykgPzn+IoW2WvPqrBio2IohKDC7j3l4HFvbsoomh+c/iCKe+AQ2kmaDjY/QWrq4sREyhY9trSe8WKXgfYZKM2bN/nKHBvLPHQbExHzJdIMgEdO/Uid8fBk8u99xSpeieX9dzvcFIA2OmUIbzToX6sIeC6G4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAWJCr5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA4FC4CEED;
	Tue, 15 Jul 2025 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752547227;
	bh=zG7a8e7HCQT3UlfAY8UglLJDThyVbih17GkbrYPpo8Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gAWJCr5QzaHhkk8GAZZ1Gu2aobAVaKCcbaBfhA4Cix7I+YfBMxGysFpl8oZH3JvOj
	 xkLbArBdM3r+IikHNl3xhWUjStqlCVcMhnhKrvFEd4T2JC40aH6J4WQIPFbye0A8uL
	 7+YopS7V+a+XDO4b904qRSheZGnGsl3BTle1ZLiGNHdJ/L10263sB9ENRp6nTJxlSt
	 wIlJKz8wAsLG3S9qGEUB74cmnpK/Up05xwYLMJJ1bzTNUnlvwDEE9vMEblzYwcr8Yj
	 zuPl0cj1tVx5/DN9iCBR3KEamxZVj3T1UpDSG+Ez5GsammmiB7hRzDzqVv+NcXoMig
	 riDrVW0Pv90Iw==
Message-ID: <c9261d4f-635b-4c40-8d55-f973a35f5496@kernel.org>
Date: Tue, 15 Jul 2025 10:40:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] erofs: unify meta buffers in z_erofs_fill_inode()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
 <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 17:09, Gao Xiang wrote:
> There is no need to keep additional local metabufs since we already
> have one in `struct erofs_map_blocks`.
> 
> This was actually a leftover when applying meta buffers to zmap
> operations, see commit 09c543798c3c ("erofs: use meta buffers for
> zmap operations").
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

