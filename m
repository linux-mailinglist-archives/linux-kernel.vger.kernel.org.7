Return-Path: <linux-kernel+bounces-737994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33288B0B2F5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5DA2C041B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F296FC5;
	Sun, 20 Jul 2025 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jtfyz1L3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261738B;
	Sun, 20 Jul 2025 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752970498; cv=none; b=JacthW5KlH/VaPPKLedrC0XIuXMiTQmp+vKdl8lu8Hg8RSwkX4mSyR5+qbPL+n8eH9l5m8+q+HRxuuSPP4mrX4tqXa67WQdsiUuH/v2RxXtInhX4FXjItIg2NpZRa6x5OVmtIJIGdXS+tJd/xjrkszmnoTHFlV3Jyyf/3tPNyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752970498; c=relaxed/simple;
	bh=G1/dZaBRpiQ/tjTY64phmm65jrLyhGkdKDScgV1y56s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMuWteEyjlzNHOjmuoypDoLdPKtrXEAnGEypW0jnZBvKDGLkpktYKsGpgjnUeh1RtuybPqZtsp+T9gWYIMbI91BY4QX/R+EstxCOtErLlt68TXAAghO2HctwrgHRTNoObk5jyTGbD0oACqrAekf3Fxz5D/TwlCyitwaF1j/Z9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jtfyz1L3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6GeynWdjF5Sj3dCcnbubxxl6buoqVFvG9eDMBikw2HY=; b=jtfyz1L3XTwI6DH7qsGFdp67vD
	wOznjn5rjOcx7PuUebW7TzI4gs1f3qoVkOeEzwI7DmR0dKokYzWRhF8mvAYizQiO40di2nYHmkCF9
	XSWIQie8Vq3sBJs1Ao4trv+9wuVzNOGjo+gsBUANRy72xdbawa7muqMZ7oIXP1Y6kN+muZkpTnWpC
	fQnOSEcnGLOWQWc/eehCL2/CP34y/aCaA4fy4H3GcI+GjR3hXuMNY8aKfglZAJfM8iURn9UxvEFli
	gEUkwQBoJONnsohOBcM2dyuzYruqgEpdPeLfw7o9N4KHkQal+E1hRL/8karAge2lvx0epvRdvI+4R
	p5LmhvWw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udHhY-0000000ElJu-3xLj;
	Sun, 20 Jul 2025 00:14:48 +0000
Message-ID: <d73bc572-5895-4b90-8b5c-72ae9c949559@infradead.org>
Date: Sat, 19 Jul 2025 17:14:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Fix kernel-doc indentation errors in multiple
 drivers
To: Felipe Hernandez <luis.hernandez093@gmail.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, corbet@lwn.net,
 alexandre.belloni@bootlin.com, ondrej.ille@gmail.com, mkl@pengutronix.de,
 James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Martin_Je=C5=99=C3=A1bek?= <martin.jerabek01@gmail.com>,
 =?UTF-8?B?SmnFmcOtIE5vdsOhaw==?= <jnovak@fel.cvut.cz>
References: <20250703023511.82768-1-luis.hernandez093@gmail.com>
 <202507052123.55236.pisa@fel.cvut.cz>
 <b56b9602-d715-4de8-903e-7c97423bf5bb@infradead.org>
 <aGsW36iFMyp4ojdf@archie.me>
 <CAGRSKZgTwHRvjZaA-HzHHiA3qhN6i-v=tLR8OsBgiJMe=F6aig@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAGRSKZgTwHRvjZaA-HzHHiA3qhN6i-v=tLR8OsBgiJMe=F6aig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Felipe,

On 7/7/25 6:43 AM, Felipe Hernandez wrote:
> On Sun, Jul 6, 2025 at 8:37 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On Sat, Jul 05, 2025 at 02:36:45PM -0700, Randy Dunlap wrote:
>>> It needs something to turn True and False into a bullet list
>>> (non-numbered), as documented in Documentation/doc-guide/kernel-doc.rst:
>>>
>>>      So, in order to produce the desired line breaks, you need to use a
>>>      ReST list, e. g.::
>>>
>>>       * Return:
>>>       * * %0          - OK to runtime suspend the device
>>>       * * %-EBUSY     - Device should not be runtime suspended
>>>
>>>
>>>
>>> I don't see any of these kernel-doc warnings. I would guess that
>>> either Pavel or I am using some older/newer version of whatever
>>> software is causing this.
>>>
>>
>> I think Sphinx reported these warnings on docs-next tree.

They are actually docutils warnings. and I do see them now,
I had just overlooked them.

> 
> Hi,
> 
> I just wanted to follow up with the thread. I had inadvertently done a
> reply not reply all after the first series of feedback from Pavel and
> Randy. I agree with Randy in that the nested lists be updated to use
> ReST list syntax. I'm working on a v2 and spot checking the output.
> 
> For reference:
> I am running docutils (Docutils 0.21.2, Python 3.13.5, on linux)
> My branch was based on commit 50c8770a42faf8b1c7abe93e7c114337f580a97d
> (linux-next/master).
> The specific error(s):
> /home/linux/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver:526:
> ./drivers/net/can/ctucanfd/ctucanfd_base.c:511: ERROR: Unexpected
> indentation. [docutils]
> 
> I apologize if I should've started this work using the docs-next tree.
> I wasn't aware of it at the moment and was utilizing linux-next.

The linux-next tree has these warnings in it. I often use it for patches.

Have you made a new version of the patch? I haven't seen it.

Thanks.
-- 
~Randy


