Return-Path: <linux-kernel+bounces-820223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC1B803DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09361C06377
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593D3090CF;
	Wed, 17 Sep 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="qRXHxTPC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9FB308F08
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097043; cv=none; b=KBLai7Xs/IncmMDhL9cidOB9PiGNBAXjL51Rlv7ngN1rYzi13Ic9+GO3VpnplHIo9TQ0vEGdDWt2f7jJ0M2pktbIFXBK5x9MiBXpPqm2GUJmBRmBwtNe2Z/tRZWGwf9d/9kHEuMyoY3O9wDvXxzsaS2hQ2RlabNRY5df3pmx75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097043; c=relaxed/simple;
	bh=p93rnHzaYY1EKGqqeaVdEpYdoaH3KDGBdfemxVFPeCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uvan5bNGdMaRkrCZsjuYegf1T1yVLuxx2Hc6t+V4tYUvHXwSm0s3OVrHFuHtIhLL6VNBUx0E7dyyRvEMTeXJHcQVZ4o5pmYwtyxbQHUCBOlTfFedN1X4vE20bWSoc/5FUZG9r1gLqgvhb5wZjoabz53audp+EO7/7FG38fQHTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=qRXHxTPC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so23208755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1758097038; x=1758701838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cfwZOPZzFsvlNm3ek81Eqwcg/vwsqzjRAGhBUvpRL8=;
        b=qRXHxTPCTBdbsAObIFODtaOgNLWQMzUtrNxMcwuJzntW6EcNYp3GrZ2lAx9DBSihdm
         1jneNHCdWJYkmhMv3r5hp9DkDSyV8HMsKDbzFLgaqhQ6oJ/RacXpGN6Ql/nMZMHAVPcQ
         XC62ar4Sqa0wDhLSPfJuXY+ZDygirtUcjybxUeJozYWijQ/BFDEAl5ONn+lhvKw+I7fC
         fIlNtEcL63yXj1zdXLWjzEskOVWLL7Ea7LFrFGCUJpoXS7J+kqfypMJDC7ax00xHA0+t
         xXhp30/FF2L6LU8NR/fBarwxt89cuAuMNbIaBzCa5HyIo7uPIYod9taBSgVRn462vboX
         OQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097038; x=1758701838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cfwZOPZzFsvlNm3ek81Eqwcg/vwsqzjRAGhBUvpRL8=;
        b=J50IItrtnlnxYfkxuX0fbzza1lLTKlUs9V5TxfR77kh1LJNJU0pzIGdHkBDglDDESR
         Bn5Bm+A/Zq0AnSO176hPvI93AsTzxOv/g5TdIsB6QoAnTbRt4yt6m0m4avUdEUhz6OtC
         289Q3lEZd931JqMpxIRqLU9nuEOLDndU54HNSw+Xfzea1n/GdhTyy5FW2O5N1AkgLGdO
         MYCf1w/XfE9YaGMsamuqL86nubqj3oSE3Sys+rWRDey0lQsDm3cyoQD2YQWeFqtNZ8wM
         n2so77bc80zj51fECXkE+3FqQOk2ss0kAGs1ToOktZ/usG1X1zg+Eg/AC9QnlaGy02UP
         ZS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuruSbNx8avu86EBmWKgo6StWqFxpy3FAzkQzLzoIh6mU3LNPuc8NMhqWyC1UouBQlXxSVyQZcj4eHyTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlmIjhq6gAawDcrb6gth0sr03ovS5HhGIzf8RFQMaF5ELxyYn+
	1r4NIG4J828921sCaPEYtk2rB+Hjb8TxjO9l6CPy7jXd7YBFrKyp3XNWSgxHcP2J9oc=
X-Gm-Gg: ASbGncs/rEk4ouDsSg1WaNKbjYQOMsG16gdeRH/tvnRXWw2FWI07lncrCspvyY616pX
	C3ZS8XNuKMEsSl3/Kfb5UbvSF7Mdl8pLvbx+4L/HJVINMvMMnySNs6dTEU3nmwOY5eOl+m4L47y
	uhyjZPu762RfMji1Z1jShKNkdjDVD6f9h1G7CYOBc1OlzqQHIaVxmHUZCQG2JCt+z4xN4yseVXw
	jIHqYsBprQI9cfdTnBs8OM3n/1rvGuJcII2eus5l6eI5oQzFJMUSdNFWiMVKQX5VN/e1JLmcvb2
	P00Eiw2lJja8yFY0cH9YWqTkJEGSWm2qHbREFnY08u+LedSPKGmQPHLb7ucudgIy+OzYNvkXbHi
	KlrrPh4epbdb17+gO0R8xrniE4TgrL/J1DBqW7RAYY8UUs2KuWf4B+kOp4WoZQ5CDMer9U0Yhra
	Q7cBaaGeAmDg2rPQ==
X-Google-Smtp-Source: AGHT+IHQauNqpq8lY/6H7jPfKtMFBDpqtFt79W/QicqW57Kb6YWQ9jdKsOFDxKIhImInFtNC7PPBqw==
X-Received: by 2002:a05:600c:1554:b0:45d:d6fc:24f7 with SMTP id 5b1f17b1804b1-462074c55cfmr10061175e9.32.1758097037873;
        Wed, 17 Sep 2025 01:17:17 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:1b1a:e580:5909:925c? ([2a02:1807:2a00:3400:1b1a:e580:5909:925c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32081248sm37379855e9.0.2025.09.17.01.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:17:17 -0700 (PDT)
Message-ID: <b76520ff-f039-465c-a58d-8f0f37bd1664@hammernet.be>
Date: Wed, 17 Sep 2025 10:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] riscv: dts: spacemit: add UART pinctrl combinations
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, dlan@gentoo.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
 <F213A85E78015F1A+aMpnVc9S_ynYGDF8@LT-Guozexi>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <F213A85E78015F1A+aMpnVc9S_ynYGDF8@LT-Guozexi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Troy,

Thank you for reviewing.

On 9/17/25 09:46, Troy Mitchell wrote:
> Hi Hendrik, Thanks for your patch!
>
> On Wed, Sep 17, 2025 at 08:59:07AM +0200, Hendrik Hamerlinck wrote:
>> Add UART pinctrl configurations based on the SoC datasheet and the
>> downstream Bianbu Linux tree. The drive strength values were taken from
>> the downstream implementation, which uses medium drive strength.
>> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
>> hardware flow control conditionally.
>>
>> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
>> Reviewed-by: Yixun Lan <dlan@gentoo.org>
>> ---
>> Changes in v4:
>> - Explicitly use 0 as bias-pull-up value
>>
>> Changes in v3:
>> - Added /omit-if-no-ref/ to pinctrl states to reduce DT size
>>
>> Changes in v2:
>> - Split cts/rts into separate pinctrl configs as suggested
>> - Removed options from board DTS files to keep them cleaner
>> ---
>>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 430 ++++++++++++++++++-
>>  1 file changed, 428 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> +	/omit-if-no-ref/
>> +	uart2_0_cts_rts_cfg: uart2-0-cts-rts-cfg {
>> +		uart2-0-pins {
>> +			pinmux = <K1_PADCONF(23, 1)>,	/* uart2_cts */
>> +				 <K1_PADCONF(24, 1)>;	/* uart2_rts */
>> +			bias-pull-up = <0>;
>> +			drive-strength = <32>;
>> +		};
>> +	};
> We are currently using the 8250 UART driver, but hardware flow control does not
> work properly on K1. We are considering fixing this when time permits.
>
> Should we add a comment here to avoid confusing others who may run into this?
> If so, I will remove the comment once the issue has been fixed.
Not sure if I’m missing something, but hardware flow control seems to work
with the `8250_of` driver?

On both ends I configured the ports with:
`stty -F /dev/ttyS1 115200 crtscts -ixon -ixoff raw -echo`

With this setup, data sent with echo only goes through when the peer is
actually reading on the other side, which looks like RTS/CTS is
functioning correctly.

>
> Anyway,
>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>> +
>> +	/omit-if-no-ref/
>> +	uart3_0_cfg: uart3-0-cfg {
>> +		uart3-0-pins {
>> +			pinmux = <K1_PADCONF(81, 2)>,	/* uart3_txd */
>> +				 <K1_PADCONF(82, 2)>;	/* uart3_rxd */
>> +			bias-pull-up = <0>;
>> +			drive-strength = <32>;
>> +		};
>> +	};
>> +
...
>> -- 
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
Kind regards,
Hendrik

