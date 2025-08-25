Return-Path: <linux-kernel+bounces-785535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84700B34C29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB8724475E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB02836BD;
	Mon, 25 Aug 2025 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bcaozo2C"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7723D7F8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154397; cv=none; b=pVkKaTqsOqPqhHvC9MJKSW5Pvtw/uh65hrkppckZ+jc6nCTtydj1pALWEXBUeLIC/Md+FuK9myzKGCECIlp5R1tmSWsMbvlgPIjRaBFQQpMKAujt6F9bTerWD2uxWDAVnVevz80HF7ZaJuMH8Hps0qR6yeeJH9G6DH8wTUq63I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154397; c=relaxed/simple;
	bh=VvKAk/8cKyRe1qgb0YWmnvPuVv8Ek2+TkhgQSduf7G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKpbdqAyMsxXhRqrEsuehhMNLyb4b0vAXt2YAcjTR+ljAZ+NJniBHLfkUnNw9SAGDfDJ49CklEBkYhV0Eax9vhNG6R78EWr61DCkVS57AMMkThzhimslDRP2ASEZ9acygRm+L7Rr+ZSayIayGSDU5I4gvrMWdKveBEGiz1ZLB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bcaozo2C; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aed65fc2-8d34-4407-a049-fdc1ff5111ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756154383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvKAk/8cKyRe1qgb0YWmnvPuVv8Ek2+TkhgQSduf7G4=;
	b=Bcaozo2Cqb4zokrxuZI4AcokMMsLwEu3Y7C4K0uIeU/byqca8XjUAv2xyKC4rfPcgWb6Yq
	Db3mGOzWh5yTC8FV/RN/xbCJK+IhC/dLdcmGqG0Dt0XGTTsofZO/lK6CuzNhBZMAAI7/jy
	EdUmExMW7/TllnrPMPnMOcUe6+OYmO4=
Date: Mon, 25 Aug 2025 13:39:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/2] bpftool: Add CET-aware symbol matching for x86_64
 architectures
Content-Language: en-GB
To: chenyuan_fl@163.com, olsajiri@gmail.com
Cc: aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, chenyuan@kylinos.cn,
 daniel@iogearbox.net, linux-kernel@vger.kernel.org, qmo@kernel.org
References: <aKL4rB3x8Cd4uUvb@krava>
 <20250825022002.13760-1-chenyuan_fl@163.com>
 <20250825022002.13760-3-chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250825022002.13760-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/24/25 7:20 PM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> Adjust symbol matching logic to account for Control-flow Enforcement
> Technology (CET) on x86_64 systems. CET prefixes functions with
> a 4-byte 'endbr' instruction, shifting the actual hook entry point to
> symbol + 4.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


