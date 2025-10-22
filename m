Return-Path: <linux-kernel+bounces-864161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE256BFA10A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25B7B345F10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155C2EC0AA;
	Wed, 22 Oct 2025 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ht7xJMnM"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D022EC0A8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111281; cv=none; b=l5DhGjmYZJJYwj9/heVZAslzHbgn7H9yyq+wJ3BtHRKTbI1NdOHNJ9b36uB0cqOUKgBy+NBIJzlwg62dQg+Q8jXTXn0C4OPWrZakFYIX7CvaMC0Xc4Hhe311xLRB3RoGUp7aSjvB69UCRiAQu6MCbFwG7nYDuQ+qLJBaukrht1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111281; c=relaxed/simple;
	bh=ldk5TdLLZTFBYkEv1AWBaAyL2fYJtBrRgt1mL1omDZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCxlAI6cH7J+CZLiaYGL2mGonySgB650RK8g3F7KDDjPHy0KPp6QeFET1jK8FhQIyx2o34X7HgM2LQpZt532sc4zYnrc1vaBUqXHiDLgpJVe2LLuqZ9bqeZwFQg3dszxENoqR6oZAmrvukAc6YeaZuQch2CMKvJ/hNFm38CV3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ht7xJMnM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426ed6f4db5so288966f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761111278; x=1761716078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mMeiaEiXQbpugBOlm80cBlO+udw+z23IitsqxhIG+U=;
        b=Ht7xJMnMSgoSwNACiMCZskGh1NsN1jQTHJD0u97FZ2oVg3L0N2bbuRYhxyZBAQh+Ti
         GwY7ah9izoB4CnlHl8FZhYwPVIPlXr0Zwkd1J/0y8w6pzDqfLBG3O9Bp1cM5468mkQY4
         MwCYa3/Y8lpU1G+DS11Xy2ov9DTIgMjg6jUzPVyWmAcfsTi4fFPHoRGGv0TvAoAbKg/n
         mPJfP76wss1uE9SCLsK5NH7H2tQVs4m3Y5Qbd+gzCX3QwlX2HBICKMpiuBvE9qviLAU2
         XlKGBGcB93y29uP3u7X7PDHrHXjOmeDFSmvitSADD2HE5BgFemxF5M0Pcgo900QHbszL
         LJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111278; x=1761716078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mMeiaEiXQbpugBOlm80cBlO+udw+z23IitsqxhIG+U=;
        b=pVI8wI2t+SizTU3UGEqqpMXQxvsqA/p8Ag+fle1LBytDFh3cE8UxYsc9nIx1lnOQVj
         rH8U45kPFbD2i2WWRrSTkwQM0j1YtCBViikAJFSh+U7qbNSknnEwHovMlu53RKj25GxC
         VBORURDhS4Olrut14mHMVXJQwIm+PvjW0e/N+ko+pFaFCSCDP5p8b+P9EMrGvFljmhLe
         Vwy0NdmcdnQ1IZbJS+lXSWBZ08KRBi4J1nk+aeIKRIHjRCgxEWZdpr6an94NICHfQgSr
         lAOIcXMsogC3HN5ExW1/0Pe5q2eTeaxCgnAqQQAie/qfCyC3AAhnckOIntEhjc64roMq
         VwEA==
X-Forwarded-Encrypted: i=1; AJvYcCU5CHiIOOg5NHT+yY2K1JihewMGrtqZWnVMT+bGKKXs+bQyYTEoIqyM+7ndv/o3Xf94qBUH6XD4qRihGcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaGn7CzfzTbVcc7kj0QZp7z5wS47dHkAjLH6yDKWUvr0oUNhy
	C4AbRR9i6v7JfK1W2onSZaPcp8wC+jNUoLV8GEwYIRaXcASIiYO+FJ4=
X-Gm-Gg: ASbGncueBc+GEAc3i9sPjeVdC/cuU/olSmRi95cPUHxAMktAo29Zb6UclqrK1STtx+i
	SzUEQPffcsizmzSEzTLWXW1xMil/5Dx0/IGvHUXj7mA2JhQtUGnoPx+n8FKxTZymhyuI3B3tL9X
	dd8TLIkRTpBYatdswlivGq50uA4QTS5Ezp1K5h2FFgIgakwCtNGYFOqEmF8ZGpbgBrQALkYxO94
	X24rYoibcC7UTgHwBHSV45mmOVPFVV7gYZ3j/ne6x7vUCYDu7sXxwRjPGRYQOoCWPKKoE7yQE8h
	NkI81zcD7zrUDpia6KCs2cbcm4ezSK7aOpMFU+ZVnx9NN7BML1IpkMSOpbU0Ut0k6qCrXdKyVl2
	nBsLjGo1LBABOFvgwrclYiPVY9Fk7O3qf3d74AyR5kFRMXn4dGMKJ2e6BNFl5RfSyM1b1xx/zOk
	WlKnWWPnUo8SRV2CTSwdJy0pKXkxsBxdbmQOPdNGwIwUgKEvXY7B9OsuX17cmEzA==
X-Google-Smtp-Source: AGHT+IElpJnBAYZBYn/zxT+dS12Du9jHuFU7OnELD9ztkVKohPHBRk6At/TgGOKVDvcl+og5FLyKYQ==
X-Received: by 2002:a05:6000:1843:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-42856a47036mr132326f8f.13.1761111277947;
        Tue, 21 Oct 2025 22:34:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42b567dsm25916565e9.16.2025.10.21.22.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 22:34:37 -0700 (PDT)
Message-ID: <2f03d1d3-8eb1-4585-bc84-d270c4875419@googlemail.com>
Date: Wed, 22 Oct 2025 07:34:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195021.492915002@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.10.2025 um 21:50 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

