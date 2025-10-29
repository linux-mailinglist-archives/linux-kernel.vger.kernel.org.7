Return-Path: <linux-kernel+bounces-876504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B0C1BE26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21ED621D52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634FA2F6912;
	Wed, 29 Oct 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YnQ4QDm4"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBD2F6586
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751353; cv=none; b=XBym1Fq7ZNTs3Bb81aJcN0CWDyiRZ/+yiUAjkLZQi4+nss/IH06FmWjx54dQBTqvZ3kEkr9zbpjSS32GgbQf2TvH1973MBwuyjDH2cwBjYpLga37GrbOv41vd9+1fQGd5N4moq42Wa/KEJn8U5Ba0GNQGJq4JXAf8T4H2Mt5yh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751353; c=relaxed/simple;
	bh=11FNa9hRxY9q6VNcHFKBCxHVTPbRkIjJRhlYDfn68F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXV0a6G6QkuHKoS37HYiEKhoMjpm/MVFYPXg/JFKsXPc8ZNlQRo34/RoL4IFKbpOAhw4pQLasxvlNS4Z1/Apc8j7R/v3CNEBRaY86SZuE4fU2uQZ/qwJ7w6UIM5s5hrnwL/O0a89Wlj+aA+FrEDdOEgpAQwSGxlo764zdk2dZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YnQ4QDm4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47710acf715so20065215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761751349; x=1762356149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgvI9i23i4mdlSoAheXdfqs7QJnRizC8cln8vFVeJNE=;
        b=YnQ4QDm49rHsjjRWPXitIFJ3YOsCHlEhNlG6bXU02+Y2aVIpzdTSZDGivd2XTauY71
         QpIcg5kJ5P6hNlMFANbaoyiKXrT/dZUFQKOrQttIMyu/zTPcjeMOeSvugqru6L2JQ5Qv
         A6cdFJ0j/IESLYTrCFnd+6wfasbKBe4WmLoeJmLYpwn9nUYZE1yHVou6+kqpwL7HWKqb
         5y2+eWPR3OptYRm6tsrff78/NKX0IttrSgi9A8iOxwtULeXF6Mse6w9mssFKzxBieEdk
         nB5gff160JD3DZASSoubzT/QEvsr5Uw2OECYtrI0ATQ8NcyYV3QXg7+eJzMBqoaloVHW
         ndAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751349; x=1762356149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgvI9i23i4mdlSoAheXdfqs7QJnRizC8cln8vFVeJNE=;
        b=TJZGFUu75sELEI+TlGB1YdSjim0Ih4002fDkoYkG4i2ecUJLo53EbsXwwExSAxsp/g
         PqbECa9fJ/jiBYpEN2FV7sTtT8/vHlZ20177sKQJ0wi6E1uePCWt08USFKDWeX3V++aD
         4C1LzRrYOOTsZFTaOkm7U16p0DTtYKCuaviib41dfUH8iRbVeyj6ekDSVBotT5QupbwA
         RsgSdM7m9pNdaapDwuPbxbaUIAlG23SenqGUfVKLz5uxDyJ0BtsB7laGQPinfQz3UH7D
         CAhz+4cj9LNF5BXzoVsRAhSxjPXdBddyT9hKfv3XhqF4ACLcn9wiPqAiX7QU7SGIQ222
         RM1A==
X-Forwarded-Encrypted: i=1; AJvYcCVIezS51t6kuNdXpRqpgBhUeyRivSlehS/swK6w7BknUGqiQWuwSlzmWzDxphywazD+WtJF/+U+3u+L5DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FyZmcGhAtO9WOwhW/jbee2yQQSzSiki+hO3jKxIACi4XH8na
	h+EqvMtGs2nq6qAVLeeWNMlLkWrS2hV3rU1wQCZTglZg7mXInHeetrRPkdvyx7aciDc=
X-Gm-Gg: ASbGncsd5rvNLZosVsJyJqp9KKUWNYvlrfTh0X4o5qDqZcJ0p4oXQQtxNxvpuzNVB/Q
	MDt6yLb3QZ1R+a3pqxMhOA5MjmDPqCgZwIbFNmVJeJEPLd8At3hp04g8ER7s/xxPuWu1oyIkgeJ
	+ucstBwY94Q02rQ6Z26tEnw6cj7VI6iE1Rh7b9VHJJ2bHwUbR4z+AlIkg23t1cYllPuX3EfcX/7
	bcaHtgAe7tM78S4iMlcd3aPF1KDl3LwW4La+vlRR1cIU0AkEjRgUrpUUL/vQC5qKmiU3XOTfvZw
	hrVw7G/aSQbm6MUGZbtqmKQTNG3UZ9ih2mnYE1e4G8YpeVIqt8MpSfjrhZCOHHpbS6PKhMhWXDx
	Z67XdFmP7+eBDT5WBIlqiwUptxf5Ij9OejF4TTiIqqXUmAsrOMx+VQY8ie1b/6lgC3WQblqycoh
	dU/PtZS7UbyXKh95/wqOHb2rh4GKLPQ4fR58gVmEEGfKoTHe108f2Jj1ZSUdG/lczLyg==
X-Google-Smtp-Source: AGHT+IFKP5qIRi1ZWE8elUAKIHMoGp81B6aQV7TyWuqhzeC/2P2PWE6cOGnUmt16+9z1GXYauzy+WA==
X-Received: by 2002:a05:600c:871b:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-477256e79e4mr6749795e9.2.1761751348481;
        Wed, 29 Oct 2025 08:22:28 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6302:7900:aafe:5712:6974:4a42? ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3aae1fsm52099385e9.12.2025.10.29.08.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:22:27 -0700 (PDT)
Message-ID: <70362ac1-244b-43c5-97cb-ebe8f5b90c3f@tuxon.dev>
Date: Wed, 29 Oct 2025 17:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: codecs: Use component driver suspend/resume
To: Mark Brown <broonie@kernel.org>
Cc: support.opensource@diasemi.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
 <20251029141134.2556926-2-claudiu.beznea.uj@bp.renesas.com>
 <bdb14543-e611-42d0-a603-300c0ea17335@sirena.org.uk>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <bdb14543-e611-42d0-a603-300c0ea17335@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Mark,

On 10/29/25 16:37, Mark Brown wrote:
> On Wed, Oct 29, 2025 at 04:11:33PM +0200, Claudiu wrote:
> 
>> Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
>> and snd_soc_pm_ops is associated with the soc_driver (defined in
>> sound/soc/soc-core.c), and there is no parent-child relationship between
>> the soc_driver and the DA7213 codec driver, the power management subsystem
>> does not enforce a specific suspend/resume order between the DA7213 driver
>> and the soc_driver.
> 
> The theory here is that the power management core uses the device
> instantiation order for both suspend and resume (reversed on suspend) so
> the fact that we use probe deferral to make sure that the card
> components are ready should ensure that the card suspends before
> anything in the card.  If that is no longer the case then we need to
> ensure that all drivers have system PM ops which trigger the card, this
> won't be a driver specific issue.

I also saw the behavior described in this commit with the rz-ssi.c driver as 
well. The fix there was commit c1b0f5183a44 ("ASoC: renesas: rz-ssi: Use 
NOIRQ_SYSTEM_SLEEP_PM_OPS()").

In case of this this codec, I saw the code in da7213_runtime_resume() and 
soc_resume_deferred() racing each other on system resume.

> 
>>   static int da7213_runtime_resume(struct device *dev)
>>   {
>>   	struct da7213_priv *da7213 = dev_get_drvdata(dev);
>> -	int ret;
>>   
>> -	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
>> -	if (ret < 0)
>> -		return ret;
>> -	regcache_cache_only(da7213->regmap, false);
>> -	return regcache_sync(da7213->regmap);
>> +	return regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
>>   }
> 
> This seems obviously buggy, we just power on the device and don't sync
> the register state.  

You're right! I'll revisit this.

> If the device actually lost power during a runtime
> suspend then we'll end up having a bad time.  There was also no mention
> of runtime PM in the patch description...

I had no issues with runtime PM, but only with suspend to RAM, when this 
function was called though
struct dev_pm_ops::resume = pm_runtime_force_resume().

Would keeping the regcache_cache_only() + regcache_sync() here along with 
populating the struct snd_soc_component_driver::{suspend, resume} be an 
acceptable solution for you? I think that will work as well.

Thank you for your review,
Claudiu

