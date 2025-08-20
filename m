Return-Path: <linux-kernel+bounces-776849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC5B2D20F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B23526226
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD78194C86;
	Wed, 20 Aug 2025 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOtpXsKt"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9A13A86C;
	Wed, 20 Aug 2025 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657937; cv=none; b=gck9gRPNxwyPJd3WVzITHLP6kVMsEc7G5rOG/2GZwXOnsAupPI9C5tCf60UXvaN83ursf3m2m2qyaegpE54jIO5Yd9oRy761f7pEfAa2+OqMQBaFWFwDzopdjRlW4y3mPF8CLuRYgLD6DtW2V5myrR2bIOGTEoB7gLIHJVOD90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657937; c=relaxed/simple;
	bh=L7qeVt5SZsS0kRQ3bCKkfVObC551WP2YOwD/5SyxzAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ovl3O+d6L4OWlQifnekfCawokqphsScaRSyJSfjDlqkqNGMbmu/63ZxfzOlEPbk3fXUrQMZYQldtHTPSukPkRXPc5pK3Zr5vjxiK+jCHZ1kmREY2pwDwn8JOq/knaDaQnLaUBgZ5ANoxZaMqpL4I7DvH9rWft1XY9gTYbC1o8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOtpXsKt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24458195495so38573645ad.2;
        Tue, 19 Aug 2025 19:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755657935; x=1756262735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QaH9gOttvajLUzldzEp6LSNgexNCpeIB1/EEz8zauI=;
        b=JOtpXsKtijRK82cAWSvFvE7wc3Rnk7burqfw1WpsfHl53Km5nSXK1+SzQsVE/8z7w+
         fXMrf+qviJftYrLyUWNZtnRtgZFh+Prx2xHVxHD59tKHnJeQ/X5gzzUZPA1YxWstezWt
         AGOmF1z/o61nEOzjVNHNKMaETt+ZYZvArfWwH+6k6zCUjEMrUvliBsVyYb7WdrDejdNZ
         qJuZ8nzULF3eGmt6NrAmEZg9ME7RhMOqtmGYe8fAiDtXJCeRtG9gzzUm6MX7i07tchx7
         cil9+PUd99NH4p2Xpic1eF3Zkdg5l6oaIIU4mX6DMgxO/oFA4efyqHLNoqrA2emyAaff
         ZpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755657935; x=1756262735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QaH9gOttvajLUzldzEp6LSNgexNCpeIB1/EEz8zauI=;
        b=ttIUpbI99x3L35xNmCGI+ZK9WjUxniZDE2bMBCcOw6gGF0W/q2i5TKvUbbjrDWmgBk
         kPS7gXHWrhHPNu+vPJ4zQR6t+Un5Duo+AdpsEkkwbw6+G6kPdFxmkHbf7PIkw7BdCNdJ
         OEPRAu6zrJqvZIE+dJB1yUGjFexynhm+9TFd0t8qlavkG1/3sXKEItd1oH/Ah1Rxjygo
         2Ohkkrt2GtBp/ZmskVYfMHFQEj3VVQb7+HjOnfFyuWFfUPtBQ1LLFh0kMZMVPE30XoKu
         aqcRWYDZ4J1XmJQ/Arf37VVG1wQJ8PqLY0InTHNFzRNLJCkuFCtP5XZ9wbYZO2Raaelp
         6nXA==
X-Forwarded-Encrypted: i=1; AJvYcCUGdgxJocsQGo5EQiLSmPQZSLv180ah2ORJ7KWj/A/D3TKV/rXqebOaz8kFGN+2qKPXZ5zUBrSR6uSa58Vj@vger.kernel.org, AJvYcCXe0G+FR7uxUubTMkujIWFxFEk+fL/J6rU93Hix7tm06sntP1uLYh3Jy1mqp0GEamdO+zhYEhpzg4tq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5J+6+EGFkBV35KSOku7nN3jWMathWyW9MuI0FJRHLf98vOk7C
	8PekB3ASVHVbtitqdeNczraJSamR/21bJ3d5hTTktCofD98Q8Xr1aQ9q
X-Gm-Gg: ASbGncvA7zx9RjsxjakGn0EhkUrWc0pbPou6EXi9DKs2oHSI9SR4RPqDTqfCii1qQ/S
	RFlDEpU9ylZo8aRnHXOswHYkrk67wGaTvqypeQBUJU9/Wl79cKeE2bUAdWv9QV5VGl9e+jCQFha
	8YjW4/MxgGRHpB+aRD1MBdwkuEZATwe1Owcif9q9K7DtMPw0ukrDCHEN2ycY0pb+88ugSw2t0sv
	mgwQ/VsaepctIeysZArxH0TbeRsoyI1qL6qMOeorPfp0vvxvY6X2kL6Hqc6c/qV0LNC5/MecZHk
	wm2v1crSodHtASOaL479sNn4fScuqh14Gj8U76NFQNpxstaKoRQZOZ6SsR9uaS+2djyFOQDpd6J
	qhBiamhFlFSERFBQ=
X-Google-Smtp-Source: AGHT+IHwxOcb3R3sB65tyCI7pwggwURoMAYM1HBPUp9ovEhH+GgbxKXoonGNqzAn1beXMKz0JUdsAg==
X-Received: by 2002:a17:903:b4e:b0:242:9bc5:31a0 with SMTP id d9443c01a7336-245ef268f98mr15307175ad.56.1755657934931;
        Tue, 19 Aug 2025 19:45:34 -0700 (PDT)
Received: from anyang ([106.250.177.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53caacsm10765625ad.159.2025.08.19.19.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 19:45:34 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:45:29 +0900
From: Dongjin Kim <tobetter@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change ethernet TXD timing delay
 value
Message-ID: <aKU2yYD+N2D1KuHk@anyang>
References: <20250819045018.2094282-1-tobetter@gmail.com>
 <4d25c642-d457-4cb7-8bc1-587edd4f1d75@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d25c642-d457-4cb7-8bc1-587edd4f1d75@lunn.ch>

On Tue, Aug 19, 2025 at 06:03:47PM +0200, Andrew Lunn wrote:
> On Tue, Aug 19, 2025 at 01:50:17PM +0900, Dongjin Kim wrote:
> > Very poor network performance is observed on the ODROID-M1 Board
> > (REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
> > this problem can be resolved after changing the value of TXD
> > timing to 0x35 from 0x4f.
> 
> How did you decide on 0x35?
> 
> ~/linux/arch/arm64$ grep -hr "tx_delay = " | sort | uniq -c
>       4 	tx_delay = <0x10>;
>       1 	tx_delay = <0x1a>;
>       1 	tx_delay = <0x21>;
>       2 	tx_delay = <0x22>;
>       4 	tx_delay = <0x24>;
>       2 	tx_delay = <0x26>;
>      14 	tx_delay = <0x28>;
>       1 	tx_delay = <0x2a>;
>       6 	tx_delay = <0x30>;
>       1 	tx_delay = <0x3a>;
>       3 	tx_delay = <0x3c>;
>       2 	tx_delay = <0x42>;
>       5 	tx_delay = <0x43>;
>       2 	tx_delay = <0x44>;
>       1 	tx_delay = <0x46>;
>       6 	tx_delay = <0x4f>;
> 
> The numbers are all over the place, but it is clear that 0x28 is the
> most popular for some reason. But since this delay values are magic,
> i've no idea why.
> 
>      Andrew
I do have more numbers in the Rockchip BSP kernel, and 0x35 is from
one of them that shows less retry counts when testing 'iperf3' while
testing with the batch of ODROID-M1. :)

Thanks,
Dongjin Kim.

