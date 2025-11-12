Return-Path: <linux-kernel+bounces-897042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977EC51DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444AF4FBEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2C30CDA2;
	Wed, 12 Nov 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqgF11jD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049530B503
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945519; cv=none; b=i1pFyb4KBX6omV6ORVGzoquP5I4f7gZXY5pi4hkVc9bRy+C3zPNWnUx83aMzcNMoW5l7pPX15EfjpY/UvcRZ+xyFmhfZuiyWJanr78nCvCk8heHuAorGtN7vPxQIh9hDpfd1idjOgP6NnWh4tMMPvUbMOif42TG9XerGKRgpkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945519; c=relaxed/simple;
	bh=fnS4LISb2dhDNc+2Ow0QDW5zzREQHSOPCznPZPdpVF4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=citorNi3X6dX70iciN/sffWXZwC+hnSWynTe/0RA0E5DIGAVTpw0B+JYA91NwTVlbgoTotmPeT6zREfn76XLgx3IptEXcqhYefKyQtxF1vJShB9blXpjlSd7/YiWFnJpYoqYXXCcAOVV2W2uMcMPHlV4/wOFGpjB0E56RhBmNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqgF11jD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98869C2BC87;
	Wed, 12 Nov 2025 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762945519;
	bh=fnS4LISb2dhDNc+2Ow0QDW5zzREQHSOPCznPZPdpVF4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fqgF11jDdwQ8KCNfgMb8djvlLjXSlnCdHezEVVl+SORs0W6RcAkuW8ycDmAms8utd
	 5wcwyxn60gpP/IpmfgqYLnpVL0Zw/ug+tcKmk0x5kWUt3+Wm0wSYC6Mv0wBBQ9GoZC
	 8TOQqu6csF78ZVeJdMF8hBHCvfK2DM0hpos4Z38M5+nZ3Qx6Ne9WVvtJ2T+pe4kEtD
	 X2NM2mMvKaZuzVWq7sYCQei6H4hbTQNIUovUenT4NfrEKGxA/k0cjXPO3+XHw/3Uh3
	 aZJ8t8Gr/EY19OTOX431jMip/nNeCpZWLZQ6Pnpt6gvblrUl3AgHJiQAVOTcT9KhvT
	 rLIBlbUtRND4g==
Message-ID: <bea78bf3-ee75-431e-b65b-1525d26f6589@kernel.org>
Date: Wed, 12 Nov 2025 19:05:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] f2fs: simplify list initialization in
 f2fs_recover_fsync_data()
To: Baolin Liu <liubaolin12138@163.com>, jaegeuk@kernel.org
References: <20251111121728.29433-1-liubaolin12138@163.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251111121728.29433-1-liubaolin12138@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 20:17, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> In f2fs_recover_fsync_data(),use LIST_HEAD() to declare and
> initialize the list_head in one step instead of using
> INIT_LIST_HEAD() separately.
> 
> No functional change.
> 
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

