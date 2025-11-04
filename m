Return-Path: <linux-kernel+bounces-885361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B2C32B00
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CC7A34CA57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1283F33343E;
	Tue,  4 Nov 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kl95E/2s"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF69381C4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281575; cv=none; b=bmC8/0EKVUM30Gm8vwv1QaFeL7lRFfxP3TBVCIgCOQRJCyuiczn5xTeyiDXcOOOb8c+np5WVS9UMZZkF9+fegtHEAS8vYtHaSF6AYpQr2/yOSNsLe7jOiCJcbS+ZveFOAfOCuXP5KBJOF3mLLcVuJpnfATlltFAbIqfQAIZxe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281575; c=relaxed/simple;
	bh=y4JMDfBpqtEwNdK6gf+kmO5Or8XhBsPZatR/guFnk84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ihxo+9SlRQ4wiYDsLnGKBNApnGe6xu7zbbHCoJKohL4ntGnV2mgneXrDjVPYDcfgRQLMPlIzO3b8mCqU1S7fsoPzJm8lbWePpzL9ns/SNVK8lkdmq0yIz1dzZEVmMySG6fe3/wv52iDfmv5sIJhGU+/WaAIzQBrOMa5ETAcwaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kl95E/2s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=K6Kq6A1aSRonO8lHf2Oysr9L8DOdIy540xhFeNq232Y=; b=Kl95E/2sdS54EXhqNCHUw592OQ
	0I6pOpEYckRgbrZFR0LKCUFWrAosO8XX+nla5HMsv/m9EXDcIX3DvfA4jmM+2zBqT6fei8BmLhLTK
	ELZDA1Nw8HGwn2bJrzzPHJACvF64hXVRI+4zMSgsjEFl9ABmOGFPmXjn4ow6IzAo1BDVbfwu8YX6g
	jb+pc0UMRpmmFs6zqDYhZi+35gE6YaL56wn37wDua+nW56680/kopVQQUnDMdkpluc/M99T4rAIbj
	TaBXF+k1EwM8V0TYrXhRoSGBrkyNqeuKzYhCnWIIQ/ov9XD8Z/ZfuOkbA3s0Mas1AEeuTp47eBsBD
	0Ne5ZJkQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGLwI-0000000CR2f-2ygN;
	Tue, 04 Nov 2025 18:39:30 +0000
Message-ID: <5f132f37-75f1-46f6-88bd-63e98bdb06d9@infradead.org>
Date: Tue, 4 Nov 2025 10:39:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: fix kernel-doc warnings in a header
 file
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com
References: <20251104004241.482723-1-rdunlap@infradead.org>
 <f1628a6c-6937-4951-8874-5fabb8c55208@opensource.cirrus.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f1628a6c-6937-4951-8874-5fabb8c55208@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 2:40 AM, Richard Fitzgerald wrote:
> On 04/11/2025 12:42 am, Randy Dunlap wrote:
>> Use correct kernel-doc format to avoid kernel-doc warnings in
>> nclude/linux/firmware/cirrus/cs_dsp_test_utils.h:
>>
>> - mark one struct member as private: since the comment says that it is
>> private
>> - add ending ':' to struct members where needed
>>
> 
> Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Thanks for fixing this. Sorry about those mistakes.
> 
> Can you re-send this patch to include Mark Brown in the To:. He deals
> with patches for cs_dsp, since there isn't any maintainer for the
> driver/firmware tree.

Sure, will do. Thanks.

-- 
~Randy


