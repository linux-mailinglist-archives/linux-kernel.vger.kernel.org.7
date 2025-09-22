Return-Path: <linux-kernel+bounces-827539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CDB9203A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248F316A98F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B452EB5BF;
	Mon, 22 Sep 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="QEZAokHc"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3462EB5A3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555737; cv=none; b=e4fHUJcBhc6ebDiQuj4tqVFOwavMvfXK74SWhPTSSgH4W1C9G6zAW4XHXIWB6K38Gmsu5cJeEBM0Jg9d7rMS3SLFcqtpI3Ibpah3aIrZoEKscEpZLpE2ZZkuWYQjpdSRyYbo3ZbEGvLLgeLGSzWYoQgXfSwfeIg8gmPKp3Z1rXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555737; c=relaxed/simple;
	bh=46Fwa5GH7T8G+aDL/8NwZ8OeukXWlDLBDbwbkFuA9QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3rUg8I1aGC5fXqy0cHgs/lXrECPSU8z/50pui68uGUYmc39YHZLuqYMOo6I+BG5CvUw0EBBqT0k7v5gZTNwcpBPoHku7Ab1NXd/HqA8uns/FWTAq6d+P2P+YTAgpi+S5lcr/PWoPPzByGC+iRTNWmsYx1MWahgR6WDRsCUOen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=QEZAokHc; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4248b320541so30245615ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758555734; x=1759160534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCb28mlSlNfcpBhhz89Sqz+h4hruBEOLY8zc9ehwxLQ=;
        b=QEZAokHcuvwKWdf5WXh4nhGBq4pPH2+tuWs/W34rzRFuP9oRXhfORzSVbubMNlY8RU
         xm/DY9BPw4xRKfPlpzSclaPWgJ8wTeyB0QzVF6cVsMAfmaQA1m8hUrmfSqhc7USD8SwL
         yb42RRkt36Ga78QdBQPZIcQ8U5klulG0OdQVRcluMoVMBrdenl/z8EK7CGyE1BseRObW
         LG62UxJlc3y/dwFt9Mo+tq3d3HX6n3WzPCVeZuutcAU+UqDYf6RUmqsQxGdQ8cVrRW2/
         05oS886aYzkgeVZKWCz+zqkmGEdiZPICzORRU9QEIB/Ej8ZeD6a0gloYKwGCbPtJtI8u
         uNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555734; x=1759160534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCb28mlSlNfcpBhhz89Sqz+h4hruBEOLY8zc9ehwxLQ=;
        b=bO04WXUu8WAUKdtxdiClbldyBEzNdiArnP65EjuoIoKeHKdMF6FWPk01BKeXunUAC6
         /fFEUNtUhp+vPHOlFSsGgbbKxWW9ZJSEc3+uXo9YgS5r2r4g3pL9kELgA9WCWeV+yVM/
         UhLFcRaUFs6dRqdGLG0XuW2hHdAp9pZVhm7uqfBaQP+ivPptl+mYutkzc+MacgXZCyDG
         lptnnzLx9gLgkym8i36sMAaGPy395iHMv4X36PP1uG4S68t+jkxQd2YwF6MSMm3AKPSA
         WYu5+fIq0FGaq9mYFDa+Im/L8BxvYYjxpfF7NTANN83pmNE1kmSueESPCxngAmAQfvT+
         xYVA==
X-Forwarded-Encrypted: i=1; AJvYcCU1noSLorwy/+JiyngF2LhE46C4FD00E3kP11Tn2Qx1aFfbQnuR1Y5HnE5Q3xgb9a4QPPmUS6NsOS9LQyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmG968m3KLnSNfIwfCRmK68wGT6BvtLL9LycbDfkX+mxVaEhMp
	34madBOnrSe3oBX4pXgH8DaU3R3GpBR6QApPn9nu7gMOzpUngjT5H09/5KqZBZoksY8=
X-Gm-Gg: ASbGncstxqlTEL2LHleH7gLvNdKTpUSf/1G1ECadX9JBy5B0hY+sRB5g/VXyIp6tICX
	OQvDiGgiRAoxdnjCAUgDrqi0Rm/IK2sZh7ChNWHh7LslBmNe6EPgRYgvNDnIoJxVaw8X5+G1jFc
	rRIJjPv/IT42cOvXU7GlgO+JfTBpuNX47Kgzzy9NMYoBZecJ5CaJMjA2KiX6FMjTYRiarz0gLYp
	HH60Q+5dfJxHxUsmLeAS03I03dwXEhCFFlKNIfWPKM/6D2waGj/+Fg6LGiTPxj/QYrPJK6kRgSf
	BAc7jVGsa6iKErwtsOE2q6IP0KQYNWAWQXIP05OcYoisjyUhqTcVG0dXoe3+t2bFhUd7FVlp7jC
	WGs8GSnc350rYA2pCoyKu/pThz/EXNaYJ1yhKR5zIMv87y0msoINAyvn5dxVoxQ==
X-Google-Smtp-Source: AGHT+IEN4LGz38AGZZTp4ukzEKIPIUkdoS/Gnv7RkPq76qCV6jt3rdGb1C+1QpNl8gxWwynbDMr/lQ==
X-Received: by 2002:a05:6e02:194d:b0:425:73c3:d25a with SMTP id e9e14a558f8ab-42573c3d2demr73984785ab.16.1758555734141;
        Mon, 22 Sep 2025 08:42:14 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afab539sm59790485ab.27.2025.09.22.08.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:42:13 -0700 (PDT)
Message-ID: <3fe0ffbe-b4fa-4585-b2d6-2437ade84928@riscstar.com>
Date: Mon, 22 Sep 2025 10:42:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] riscv: dts: spacemit: define a SPI controller node
To: Vivian Wang <wangruikang@iscas.ac.cn>, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-4-elder@riscstar.com>
 <50456256-fc9e-4de5-a512-5749b832dc3a@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <50456256-fc9e-4de5-a512-5749b832dc3a@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/25 9:57 PM, Vivian Wang wrote:
> On 9/19/25 23:59, Alex Elder wrote:
> 
>> [...]
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> index 6cdcd80a7c83b..f8c37d16968e4 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -856,6 +856,22 @@ storage-bus {
>>   			#size-cells = <2>;
>>   			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
>>   
>> +			spi3: spi@d401c000 {
>> +				compatible = "spacemit,k1-spi";
>> +				reg = <0x0 0xd401c000 0x0 0x30>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				clocks = <&syscon_apbc CLK_SSP3>,
>> +					 <&syscon_apbc CLK_SSP3_BUS>;
>> +				clock-names = "core", "bus";
>> +				resets = <&syscon_apbc RESET_SSP3>;
>> +				interrupts = <55>;
>> +				dmas = <&pdma 20>,
>> +				       <&pdma 19>;
>> +				dma-names = "rx", "tx";
>> +				status = "disabled";
>> +			};
>> +
> 
> Is storage-bus the right place for SPI? I'd have thought that SPI
> wouldn't need its own dma-ranges if it does DMA though &pdma.
> 
> I know "dram_range4" is where SpacemiT put it but I'm not sure if that
> makes sense now.

You're right.  It belongs in the dma-bus region.  I will fix that in v3.

					-Alex

> 
> Vivian "dramforever" Wang
> 


