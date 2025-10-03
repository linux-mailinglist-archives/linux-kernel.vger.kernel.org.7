Return-Path: <linux-kernel+bounces-841365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23CCBB71AE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1BA481A31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0714C85;
	Fri,  3 Oct 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdYDkQgn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE631DC988;
	Fri,  3 Oct 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500118; cv=none; b=rt5+VirbigOdxzfm+ttHZbe1jBPL99wHVA/kiOHoSay5QM0wpHGCFrOSrR2+c68VdlGybLBP9wL/mbhrTBMaNAoBqeasWa8so2HqxTJoI9yn0rfQmMNKuu2Ex1zGioi7VUZe2SvsSnlOBqWJuJwo8lURKdOX0g3HggV9fTuUZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500118; c=relaxed/simple;
	bh=cWEmbIZlt4zceWe9IpAVFrtljidit0i/by13ttV2RY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQsGuHl1xAbaOTtHFS+5Ul0RtffWzCcaMH4qzo2Hn6yOGW6r3l2rIqkovkAB7RH+mon7ID+p58duMP1FRj0Qz2aSAUB4j3RguPjEjneE7xXimPQy6FrBJQakX8lpnwHkN//TPM2qAUeLfB725Mx9iOW9YHJ6ZxBv6eJC2BiQduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdYDkQgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC531C4CEF5;
	Fri,  3 Oct 2025 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759500118;
	bh=cWEmbIZlt4zceWe9IpAVFrtljidit0i/by13ttV2RY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XdYDkQgnbItFNp2ucWSHoY0O/1IcxKths88LRAvP0uwMLtfwOuuAudSgjKlg3nWeG
	 DDqpzNCqwwqN0ChKY9FNheqisf2r3eaZaDFIDSWzGUq8LttV7ex9aNTp8pMxs+IMV4
	 dWiSMA14UvJC7JTHthDJRXHQAnDf8pPR26actgpQ5zLJ09tNkmizIGm9REzKiS5OUX
	 iZSB0tHeWWe5JZPvYI75nFj+WnDvdKlJsb2MSeNl0CSP3P0dbNcaVAzZhkPglwkNiG
	 fPlSNcTgnudo78Sd1lI+ZZsZBgb+Mhj9qhtSgOvYOHFkyly8JXoX5JAZv6i+Adsz/d
	 JN0b8T7PfcVdg==
Message-ID: <f44898fc-e745-477d-aa8c-b8df20c1db5a@kernel.org>
Date: Fri, 3 Oct 2025 16:01:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New co-maintainer for ASUS driver
To: Armin Wolf <W_Armin@gmx.de>, Denis Benato <benato.denis96@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com>
 <6c0dca8e-cdd3-407b-8dc7-cf5414b37220@gmx.de>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <6c0dca8e-cdd3-407b-8dc7-cf5414b37220@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Oct-25 9:09 PM, Armin Wolf wrote:
> Am 30.09.25 um 23:23 schrieb Denis Benato:
> 
>> Hello,
>>
>> I am Denis Benato and I have been asked by my friend and person I estimate Luke to help him in his asus support effort and I gladly accepted.
>>
>> As a first step I have refined his asus-armoury as requested and resent it upsteam [1].
>>
>> With quite a few more work on the horizon for me, like the hid-ally driver, adding more models to the asus-armoury driver and working on the xg mobile interface I want to ask what's the best thing for me (and everybody) going forward?
>> Should I be added as a driver maintainer? Please, advice me on what to do next.
> 
> I suggest that when sending your next patch series regarding the asus-wmi driver, you include
> a patch adding yourself to the MAINTAINERS entry of the asus-wmi driver. This way contributors
> can automatically CC you on patches touching said driver.

+1 to this suggestion. I think that adding You (Denis) as
maintainer makes sense and this is the best way to do it.

Regards,

Hans



