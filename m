Return-Path: <linux-kernel+bounces-873000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 908F8C12CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02D364EB821
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA7273D81;
	Tue, 28 Oct 2025 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTv3uyI9"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85F27EFFA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623517; cv=none; b=CV+LcUWXW/BQyD4zySpQqM1Me6dZaFIXFmGUMvwRk4JfuueKudop1zeJFZKz/5dg3xjHzt6tuUdtLzDVNtyHV/CXWk93QZS5+MaW5nfsawEgLtzK1ZMOozbdlHayP3FbbPIo15dOZZWw31Mc8aJVm2lWzt7Ko6rAoCO/olmueZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623517; c=relaxed/simple;
	bh=5xMYtSEok4bYyLtlLowAuhEnBHAtxF/58LNkN8fxapg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3wqjSntHPksWr/+j7nbZmhIKtE9BCjoCx1uqsXiAldkJSocRKJKaPqetfIyUvR8xe/34mPn0cn2UXZj/TX87xkRQYwIoaITXq3JVMCfn9fPRzyaaG/fbIGxOnq747+273OBlC2/FrM8i3M3/yvthO8bbWotAwDCW0/d1GI6NSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTv3uyI9; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed7e7c83-6ff3-4a10-89ec-1b38610fabd2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761623503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwVf5Z+boA1bEp6FLhaWmibblYnli4umc6NlcbXHDZc=;
	b=VTv3uyI9pTP9vVQN+eL9q1tbWQIzsUZQBv0c47NoCWr3YGGDaqppbAe28rwLwvMlOQkmbz
	lHZw/6NmG6bsDxLYjiytjC4IezQfaqZZBMrvUDYgNB8ophi5LzWC4I3e/pDscd2PX3/HH/
	PIX26TmsTcqvLQnWFCPhvhmJlvKtE2M=
Date: Tue, 28 Oct 2025 11:50:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 06/24] smb: move file access permission bits
 definitions to common/smb1pdu.h
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org,
 christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251027071316.3468472-7-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd_LqhpKCJAPKm0yBC-G+tTJpVQJSoTCbEN7Gdz1kMnQDg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAKYAXd_LqhpKCJAPKm0yBC-G+tTJpVQJSoTCbEN7Gdz1kMnQDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Yes, maybe I should move them to common/smbglob.h.

On 10/28/25 11:36 AM, Namjae Jeon wrote:
> Please don't move them to smb1pdu.h.
> These are common definitions that are also defined in the smb2 specification.

-- 
Thanks,
ChenXiaoSong.


