Return-Path: <linux-kernel+bounces-775232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 983B9B2BCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8365B4E2BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8521990C7;
	Tue, 19 Aug 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kdpflB0T"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350925A631
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594996; cv=none; b=QEvjVBr0LYFVIAJIIEveq4BiianI8guA9VEQAQT8qv4aa9LxOnVc1rVjbX2Uyy/AzR9PuHTwHNf4jWp/8I2Nqcnq6fTMTgkRwaVtzbb4WHa5DohvlYA6zICcDboQzvxPo3N4kfvBZ0uqI0FMOZ8WQsK+WdlzU1TgYawK5IS6+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594996; c=relaxed/simple;
	bh=eBYVJ2FkORuTwqWvVkBmCDP8mHAzlrBhN4QFixSH68M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oJ2yVHRGoVVlfc0O7uuWhPMKZ2n3NTtUR/BdqpsK+0wIobcfiMEtxCEWKj5SSSP0dMQbBCHN9wDqzbiDr/mwJsbsNbr13DWYcQC3+ZX/9aerUFKdVkoAru6YOldxi+aLPF8pIoOQVzWH+WSZKmKtimIJHJ1j73HXt741p3K7XFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kdpflB0T; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755594972; x=1756199772; i=markus.elfring@web.de;
	bh=eBYVJ2FkORuTwqWvVkBmCDP8mHAzlrBhN4QFixSH68M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kdpflB0TjkM4sUfl5fIKS6zpNPXrY4PrtLO5iZNIZMatMzpjY/OBIuodfg3Hc5ud
	 QldIwpDodqEv6xmyU7P5qtkwIlcBEKuoE31MdZtZlvpWdb84VA//2WULjEJPUf5ba
	 GXbq+pqCkizeqdBFx+NK1OqLpidEYIVJlvG3N9BXHq2EMAoMfnnIwK/HCsGEtcxS6
	 C9mGx5ZVH6RSuR+9Pn1Dp2QGMLDXa6jYuEcEr8D2z6P6TbNH7p6I8EQ9UjSMUvN0z
	 toqqzLyvxNBNIkuGZqisiLtEhewIPrPmx0Yv6+MODHBQSr9iRcobW2k/UE+gFt/L/
	 C24oriShYd3E2sESeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIF2-1uzGnU1shk-00Uyrc; Tue, 19
 Aug 2025 11:16:12 +0200
Message-ID: <88fd2a23-ecdb-47ec-9328-62b9bda7bff4@web.de>
Date: Tue, 19 Aug 2025 11:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
 jfs-discussion@lists.sourceforge.net, Dave Kleikamp <shaggy@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250819032816.426276-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] JFS: Remove redundant 0 value initialization
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250819032816.426276-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EN4AWiQJyFq1Sucoj9nMHzU1fSTvsh2ltNimcq0EnQBzor0dk5h
 y4X9SEyLDjI/H8lujokVCeIp9dmpTod8/YnHFI1F3sxzTs1Q0aRaqMhOc41SvOB2aHnYdI1
 f4PuWPq3Aybcw83/c3ljizEQRhbqqDiXhNy5mq2vrj0csubb5nhLiZU1cGMuR/FdBLa6GER
 BTXmkqMRjcs6NUV/vWLwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EGSQzH2KABU=;1rBwsA1O/UvaT/wMNkcwmjeZ1qI
 b6UTwumo/8WT2coQ49d4kVZyWQAVF5UAC8+xKDc/nQskNrPbnbqavUkSEIMy3DRPRo6zLWsd0
 X5YmFnXzWmaexMUrFbRVbT0zrWpXJHEBsjEUQ75UuSqwIehKjrk0ogAFzvL6snEiFglvXDIc/
 gN9x2MM1YQfpwIC/dkgXHHUsjRO1zd6FwQLPD2zx9dxCmfVFFPjABroh7fCxQx3i8lJL1/b3V
 BO7MSm59bTNRJVuGiA4rMLbY2SoT0RRqze+qTMMvWeUJz8/DeW+NYa1u6sr59kkqosL+/3z8a
 HG/yfWcoi9aIs/HszmIQsBpymWTFWF1fGZLj8Ajj9TvEogzNAutsFdutydI/62iYfWIyCwO6f
 WwvzqIH2Sm29UXSMApDE4cJ9qbC/0HIapqHBSrfP6vpdV6DvRYI/HJVjo+OORaSbUxXX7SrdI
 GMt6HuM1q1MAe8ZxnFDWvD0nnYV9spc6An/Ppe1o4apvxWyNkFLCj//vZCcKcY54b2U+ul4IJ
 BdFEIIfVSrUkxp57PlbRwD72zmKNb/rtKvi1UchlM2vb1Pu+RW9wbHR1wIpqmJgqGwPLu+bAP
 g8UFqyYSFcDXmZabnVvUZjQjOaJ/CEFPuwGoh5ujR8QujQ7otTXr6+yjCopfAUHOOCcnX68sp
 IO3uJ2kksL+u1xCPpG5CRre1bw+bkffNv2xe1KnYZ4G2ls5Vf/+y+YiD4luoBPhODCjIpWJnQ
 TiwXEIj0Wwf6AEgjQ9ySuo90Prm/qkvAvcBMlhIW5VVW3N91CPO2liAIiAIOScUsSHu9XgRHo
 WCfUKjUPhZfiZfW+kPNc9p9bmRtqqbcEpswiwf6NgBcs5qHjNptqznhU1JNW+YNC+TlyArQb6
 hzp62/vm6AOtpw0Tj98vhOcu0n+t3717C2FU/wIr2woiI8oNsbQ5Y2fLroM36Yaod31tl0EKP
 U2XyO26dgTZbYhQQgrH4vpi7uLDggFkVHIIwBZnnlSQhnPcgJHWlsWAD3ai+6PczmzgunwyKw
 wBJkJ9CkGl8uKNsvjb9Zv1Cx0csiIUiiW1b52F329hXhzUoQJJ6LQuy/2PT/wM19bcpHFaTLy
 eij+BmxkVnsH40hA1D9HZF/uv0SHX3xf2R3qpnPuDkWWlqtRWfzdLfGxBw/bOZic9TW8q1pwT
 99fXRFYLvKVVXV3rr7W5UenqZR9lgCkJLC5rOSf5YFKjkgtl3UH4RUp7Kavp1vKeGuph54uxX
 Y6MchL7Y9KWftnihFUfmq3OVJih0F06hKSDkvY/vJsW5VfSr8xGQU38PpaKpfo3XBG1YjXGLm
 qvWP0G69qmF8E7qHBJdt0GsuZ3GtsxR1Kg3/1McDwQyoSeo6/LVXmUUxDNAVZk0hYzHnpwpXJ
 U37C1c9A1EHuyyEbZdMLzb/NxcDrEjyrEo8k5yESR/zew5cmINaYsm0d9Fo1w3A4A07/Sy731
 x4ca9DRW49MDGsHDLaP1dlzo8BpXCB5lQMbypI62QrupaZSEfQAXmRLhCcDjBgsmve0s5fsq4
 6EeiTCVn2H/atb/B6+fjTHaZFlXH+HhgPNoQH+PO0jf1NXv7MOSpc62Mmz/yYj6o0z5HHQumh
 ISxdHOrZqJlpR7BjTm9c9v6+GES2koynfDRwKN8BiuNxvGm5G/psJ+ZihKPzXy5LjHivR+3GI
 eHVw47kOMrGHzIPiBI4/mP42Q1Fys4lljkH55ZT8nz8f+5oU6jpgbIVvuWE9+0gnaR4i8IuIl
 RXFbwdV1hXUVonZ1pFR477nCyJhVuF/MUoyECC2ck+w98dIoiu1aY+YrTbuosH8+5V1+n7qKe
 GFuWV3pfYQwN+0zs5BIv8gyxJ6+hFo4KGzSRY+MzCGwcFX8udzladDll60+rnNQ2g8zM37YO4
 fFCgaCny/+08pLCv1iyzA/8GQ9jPRfyo/sOaLnjIiZhFqrZVdLVqCHKhSqFL0wh9Zc/+PJxSx
 1hPEbqOktwgnyYKz/3FXlG0LIIpx2MxqtU775WsawdvmIvA2JyvBnV5HpUiBuP3OBGkBPUi9M
 /SdddteEypFpeYW3WMxYjNxMItnv7VA2usg4AZnjCGP+/EQA+H3Yuv3EjiOeitTH+110SBx7V
 /KFARss4nw1ybqCS0ABZ1WULmto+F7YH3JXcnO5Z4OjREXwNewcpHXAp0Om+GAW28csabnvxm
 0lYeVWJ7TSs2dkRqQYgo71d+MsJZtZt9PFkFbNrNOA+e7PZGj/4+NH69RKcYzrQAGqF3RAo64
 IjN5nY1OKoe1vRxLxMQXQ7otkc4BXQO1XidDKiPukN9QRhVEe+ZK8JFX4K++QeFDeJI2lIHaw
 sjsUp4CE6Db7+eIfbvsSY5zxpgouekuqA/4ombAs+Y5jdPfZ79yvVqdTXRxyxcUtAeiXhpSY1
 PdVUCmwsY26/VtPKOAVMa1dWfNPhhCp0WuP2VXC0ZhAffpoj5Vm6762SU4XT1HsELWaoYOhqb
 CTaWGrtqXk0HWZxQMdtT96TBo/3z+QbBNC7BgOL1bNPfFF9rcdIt5XGR3F+hcoz/0S/uroqpu
 97ZlFIOtxXnAZl78P4TaVn02pNVobtYOpzSDA/UwiA5b0kLywsWQuzZkCNwBd0B2hDvj0y9cL
 FJHiAChXSpMwRObURjZxR/n4drJpN8awo9nONeM9T+8EDJ74CFIGrohzrqUTe3EyVhzTVpHtj
 YH3NBex9xxTaq9U/HLjOEfw3ebPcbKG2kEQu5Kgj0TnDquTd4m+prnX5kTWAKO5mNtO2Clsrs
 YK/cr8R48+4xzkW1IuFpOOxsWfjXSqq1NUoencsEnWjEXhK8RdlXbgUDXwWpcvQmEiBDoterp
 ZPorIR7naZrpfR/QBoGVGKsBRvyWStWarMfsmTdkldVkcYxH+O7NU68TszeMtPiU3prGOUUpB
 lxSH0/CfNPvHJpN1iFyv/dxoc6HlrbrgagB8+TJ3VaV7fJsx4JOKPup8vKf9olhDe4D7fyu6z
 UN6itpKHmxSBlBrOXpCP4drUdi5e+vlqeu0eEPxC/Kv1vVbkwWSRbG0+rSb+/3pKUuFLzb5JV
 7R+T0w+YaGAFIJS4Wd6MWvt4RQZLua/IOj/Eztka1rl5K4/ZpLCLzU5w4xh6fyNJKiCt6ZTlg
 qdbPYYhTRjbogDiHYwfBabUkit6U7hruZJaGItUqqT/ZfhQqjRTAziHMqAg28ehlJeD3nEvRc
 aKtblWeqmKeMO/9u8N6PF8ZIytXLLrH0SwowCD9HW2LcqC4xGZdywOMJG9b/iFH7nLIYUw8hC
 eCkUdGG/Hl9MrGylvyxJnexr9O2bFsPMm4Y2K8qPrOe6Oy+8MKk6Ub/Tq/mumM+CBEmzJtN4Z
 jZjJedf3uWZ3cqoWWKFp5u2E8c9IGfd0ZLQwBp6xj/MVPpIFDXqymWAgkTwQinKz/2W1tstoG
 4rIU//LATN+EKXzZZZlblHEqmJvBAT5/jq471w70EyDHRE3dYi+Lodo3XtirmHvlvOd3nndbB
 biQqzfALo1vukLoUrelKSfg8+v4b4OE7K9k/PDu4ySMlTMnq8/GVL3t7qEbYKoCQtPdrzuiSn
 hygwXYnmtLlFAOy0pVLhkqUa0iqB1uDI3hrD1yPXk/H3goxFpcIqjejdl38skOtPg2is7UuHi
 vbn2XIOsV/nZ5AGpNhPv2kXGlJjvlJtnZw/rYDJvhwLWqicFVZCcwptDqLFG7KBP25YnTaw1L
 EU2o0cPlmzh4CwZZS6cXj7xP5oD5dWaJofp8Eg6RlKEubP9ako/ykorxxRV/shqrA8/3QZYAy
 SqqcyYYdj6VOHDGjh5o4tZXunaQn9nT4aQylhkDUAdyL+SGFn8tPCgPlyeWLfgVeoyDvQ0Gk2
 eQHBB2mOBeUI+2/NL2ANijGgzjKiAwFYFwjCPa++rsecQqFFntiBLDSxg0ov4D000+rll07MM
 23GqtwCVRO6NT0dzqJSCuH8IsR5kdngq1wi3L2R53u5hamcVvl6NT106lkRTRNQrkwudKn1LW
 M78RfbjDO0c1W3Qf6DDSbZ2SBLX/QSKICFUeAgq/8jFUMRw77w+cWILcas8DJVzPtluAnyQSj
 EzESVm9ST0yjVFO74AO3RkKxzk8v/8i2umfEc8mRm7jdxRBgjlmgreaCiH/JzwQuCeimm021P
 own3U/HCrHSsIz2YC9r20yPxpvfz/iQbPtsJvnskTHQ92p2rYxxrHoPBUrog1r4ItdlTsXl9z
 mVNAau8/hFcHj8bEqtglx3ct0SPVQ4LfpyQ3tZI3lb1rL12DOfDdsqR6NjUlFQ/F7zUhyCcFA
 A8ax01/siygDBzkVH3YF43IRIwlf0CGgmbkh0qcrgKavjPRZ2ASgvYVB/nKH9Ymg85kZOB845
 Iyfj37pBH+TRdO+trXTuT+YRAcuadM8UuIKlmqFmW34ps39YME/pHGelAwFPL66I/hk3WXBEb
 iiIPgdH4IfeGTjniqYoYcS5n1NZ92WxPgnY5PkpXnpQQ8IutMD71W/BDDhGYcByyJWkIWCPzi
 izX7Nykmmd4RgCv92p40mt4Jt2gWUjEw/7AmDj4S3gFdgnwuoACS1P46kvFIv5EVqfVH3vRWS
 47rgS7+n6ghESHR23hutzHpsQpxMDaSc4CqA39gMt9+WO0a9v1L0QohJTRZafqMIjf1w==

> The jfs_log struct is already zeroed by kzalloc(). It's redundant to
> initialize dummy_log->base to 0.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc2#n94

Regards,
Markus

