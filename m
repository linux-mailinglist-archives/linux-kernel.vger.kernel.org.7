Return-Path: <linux-kernel+bounces-765772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D4EB23E13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EAC6284EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B81DB551;
	Wed, 13 Aug 2025 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSWeMYdX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088112EBE7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051087; cv=none; b=HQEzlSku5JS4QVNSMJsN3Wnj5wp4xbmHNN+up/dD53LTa7P3Hc98WQBtw0ux59P5ltmIH29tO3yN7re36vGFrQAzloJ9e0tDJBAWX8tHJwblPLCXd9C389d57Y52fFfFQCDYQd3++G0kukAhBf74+SLQ54NwpfTnBboiDBQqacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051087; c=relaxed/simple;
	bh=TUqa1c4dr8SeRjsgLnXO9MFgB03+Em0g/A6drLb/jwk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EWQ1sNMTpJuCsqWhEv3uhzTt2SJxkdOY/5T0UBzagQrnvCvMaC2dwVYtUOttEwVfV2dZBjSQgNUuZqb0DdxaJFGeNzs7AcIlP08dgHyYKMyogFWmg5juiDhljpx+xt5fhG4MwOhbL9jY5u5KCWmsW2mzqVVOYlCSM7ExYAJzang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSWeMYdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E279C4CEF0;
	Wed, 13 Aug 2025 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755051086;
	bh=TUqa1c4dr8SeRjsgLnXO9MFgB03+Em0g/A6drLb/jwk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sSWeMYdXeCZ8hw9MDia+Bw0BH1ViM5WnKrugXWJWv20Wohkzcz1R74BDlqc3FMm2e
	 lLY2ttYG/Ouhfss8KO0khUdQ/vLOii6JVZymGZ84w8cyMCOoSJJ/klM15dzsre/jQk
	 f7rXwOhhPJ9SGofvx3ElsCzikoOdLzodJ32wGRgaRcr0Q/gW69v+JJOAry62aFWSr0
	 /Ozre0fXRcrt2ZvL9MSsnaULdwIVu+hoT5ACFjOF4lWtwXpyXJ22j+GoNOeQ0aL49h
	 /yurkjHz4tkOAYUsIW+J2mx4KWC87wb07AHuvW0XBQK8HSYL4J928uZB7k2Q7YjsNn
	 7SMU+Fz8lEfDA==
Message-ID: <013b29ad-3c9f-4042-97ab-839976841244@kernel.org>
Date: Wed, 13 Aug 2025 10:11:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] f2fs: add reserved nodes for privileged users
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250807133501.551848-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250807133501.551848-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/25 21:35, Chunhai Guo wrote:
> This patch allows privileged users to reserve nodes via the
> 'reserve_node' mount option, which is similar to the existing
> 'reserve_root' option.
> 
> "-o reserve_node=<N>" means <N> nodes are reserved for privileged
> users only.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

