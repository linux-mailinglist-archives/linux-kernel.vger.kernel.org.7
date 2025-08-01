Return-Path: <linux-kernel+bounces-753645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9BB185E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7351B5449D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8719F121;
	Fri,  1 Aug 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOmn5fJ8"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252123AD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066405; cv=none; b=gDU2CH523Dv5ba3OBxpVpDJl+ZhtW4r3JMWmal/SDr0sofOkT1Kl94ITP85MICy+SnRJjUwwC9YuJOWQHenE5l+JgtZqTHYRpEpPzUG77nZ6R+XWQf48NAxlQDE99uemDAuifSO7oyWksCJL5lcElSyWp33u/6J+uM+iu1mHWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066405; c=relaxed/simple;
	bh=MKtiusMU+nuZNnzSlyt7TmTPTE8P0GCLwFZ6bBzION8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJYpE/EbbUG/+v+VUVa7IhCX4itQQZVsQd8Z0XouB+RIxujrpfwbiropVn15XHzhAW1U5nF77ghvEP4yImRXzbee6igHW49MJxnJQLxy6Dstsr6PuwEB6YE5Otif8Dax8YUTjgKvYfs8Ot3P+nYUo9yO33VDTL3oipyyrxzV8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOmn5fJ8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb1f9bd8-02a2-446c-a22e-f5274d9cd080@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754066391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MKtiusMU+nuZNnzSlyt7TmTPTE8P0GCLwFZ6bBzION8=;
	b=bOmn5fJ8uBtr4AptHzsQmY7BTlQ9zCcpDeVtkbG0arXQOPgdeAQKtECaYbWNmuOE+z1q7Z
	M6eYQSdPQiBvCAh/gL0WzsHpnSGttNkKCcThejHaqAY5z02pMppNzApjDPHQ7hhchPosWH
	aP3GBrV5gjqtoyUKFp0qu3enUZgg4Oo=
Date: Fri, 1 Aug 2025 09:39:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] docs: bpf: fix minor typos in BTF comments
Content-Language: en-GB
To: Ankan Biswas <spyjetfayed@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c08c2cb8-4760-4b21-9beb-2e9c204a62dc@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c08c2cb8-4760-4b21-9beb-2e9c204a62dc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/1/25 6:29 AM, Ankan Biswas wrote:
> From 85f5a63a12a8544440c0af47214ba5f55c348c7c Mon Sep 17 00:00:00 2001
> From: Ankan Biswas <spyjetfayed@gmail.com>
> Date: Fri, 1 Aug 2025 18:25:21 +0530
> Subject: [PATCH] docs: bpf: fix minor typos in BTF comments
>
> Fix a couple of small typos in the BTF documentation comments:
> * "focus" → "focuses"
> * "F.e." → "For example,"
>
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>

LGTM. I am wondering whether these are the only typo's or not.
How did you find these, just with visual checking when you
read the doc?

Acked-by: Yonghong Song <yonghong.song@linux.dev>


