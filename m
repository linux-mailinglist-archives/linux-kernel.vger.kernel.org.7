Return-Path: <linux-kernel+bounces-724505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95474AFF3C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A75F54434A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F2235BE8;
	Wed,  9 Jul 2025 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huzGxltQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2EA24467F;
	Wed,  9 Jul 2025 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095679; cv=none; b=JQ+xgj0SybSo7c5X3QPyrf+gcZRwLTymybMgq6kBV/++JXwCh3eWeCkTgwash2NZfeszOQ4qy2cDMJqHfO/1xMFrVyGW3N/wn4YsU2iZYwI6wMSof9mNVmiAoP7hceNlfSoOPCYZxElF5UPO75zsGfQhgBLnWGNuT0g58SpDT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095679; c=relaxed/simple;
	bh=P1DoSAva6EWU/0jIyHTXxv6AJdJvqc9wcq7KgycXTVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FHMI5cZUglyAo0A5+sfkB3wHJZHwByMf6V4APYy/UzJLa8dgkcjvIyAhd41vLD+3nSrwHPiXXkzWzYwB/849/fF8Zdv1WMVVGcfBqfxjyOAcVX8MCcoGq/ypLQyONHb1odDg0ojTBquYaF0yHfmXQbzNilgOPRenZwwno8SeWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huzGxltQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B17C4CEEF;
	Wed,  9 Jul 2025 21:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752095679;
	bh=P1DoSAva6EWU/0jIyHTXxv6AJdJvqc9wcq7KgycXTVE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=huzGxltQLlKst7as9HvUXStmvqytuhUDCz8MvGdlfWrwFNCK8vAprGN0100hbWyyY
	 E6t8CVQofePVHMLoXcC4HIVM/fOZKmkli94pvUSWjwsSG7Ch+i5gQI8rsEs9EAtanG
	 yAZEF8PaFupa0dMWZSumyDHRrnfvIAxOh2ALmwEydlTsxnItzyuG5v7gg0sSfLvwfK
	 Fjd9lQL7hqcFNXGG9rz8J9FbGLd9FyjiTebQjsXP55G6sbr2YB9wC6ir9BFsR2DinU
	 ueJ9z29t0CWLlp55iZZg2zgnQCORB35grOJFza/68ReapaEqbSULvQ+/D3Xd6RFgqG
	 ZOSLI2ouE1TcQ==
Message-ID: <46f581c6-bb61-4163-91a5-27b90838dca8@kernel.org>
Date: Wed, 9 Jul 2025 15:14:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sasha Levin is halucinating, non human entity, has no ethics and
 no memory
To: Pavel Machek <pavel@ucw.cz>, sashal@kernel.org, stable@vger.kernel.org,
 kernel list <linux-kernel@vger.kernel.org>, conduct@kernel.org,
 ebiederm@xmission.com, shuah <shuah@kernel.org>
References: <aG2B6UDvk2WB7RWx@duo.ucw.cz>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <aG2B6UDvk2WB7RWx@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 14:39, Pavel Machek wrote:
> Hi!
> 
> So... I'm afraid subject is pretty accurate. I assume there's actual
> human being called "Sasha Levin" somewhere, but I interact with him
> via email, and while some interactions may be by human, some are
> written by LLM but not clearly marked as such.
> 
> And that's not okay -- because LLMs lie, have no ethics, and no
> memory, so there's no point arguing with them. Its just wasting
> everyone's time. People are not very thrilled by 'Markus Elfring' on
> the lists, as he seems to ignore feedback, but at least that's actual
> human, not a damn LLM that interacts as human but then ignores
> everything.
> 

You aren't talking to an LLM - My understanding is that Sasha is sending
these patches (generated with LLM assist) and discussing them on mailing
lists.

Do you have links/threads you can share to show how feedback is being
ignored?

> Do we need bot rules on the list?

We have to get humans to follow agreed upon rules of conduct before
coming up with bot rules.

> 
> Oh, and if you find my email offensive, feel free to ask LLM to change
> the tone.
> 

I am sorry this isn't how we treat our fellow developers - Please take
steps to make amends.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

