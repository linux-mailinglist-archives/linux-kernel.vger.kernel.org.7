Return-Path: <linux-kernel+bounces-849323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3363BCFD52
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 00:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F894035C2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DC22494D8;
	Sat, 11 Oct 2025 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib/o3ZWB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A72264A0
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760223000; cv=none; b=Yi3eVZM0zHWiultnIWLrYsgTEhLKml8eHYqcEXZJB4lF/KbX/yDmE0XtWcE3klM6OFhCdwd137mut7GBmo4fkFU+UNZenW6kY8UazpsHdPJ7xeN7B/MryABj/HYseG5RTH4wYFngeT8rzuB4AvdzWyL47OqGokeXlrHgIEYgC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760223000; c=relaxed/simple;
	bh=Waw1RqPdm7Re/srwO1LAZ7agr8qihAEBDExDXRAWDdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogj/Vtu/rEsUKrmBrfU79VNDdmJNokfS1RfSnRJQhNHYk41DDE2eZqtqypUZySIXG7FWwh+yo/V/AV/eq8jSFx6Hrpzj1RWi9T+wQUIp1cAuOFCwyu+8dnB2i6AbLo3qmgAa4FqJfbDzuKafx0+t5+qgXAx/xFCaCgIenUoCklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib/o3ZWB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so22257205e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760222997; x=1760827797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yC+4EsZ1d3NIC8yIzm0IlzROUzmSGxGjCHMWgdrvoxg=;
        b=ib/o3ZWBsLOKgaKpiB5GmX+KXU8kQ4JXmGi64EjDQ6uXS/L8/YKxVxVf7jVEWaSPv9
         1iNseZiifKDeVS8XAL0vRsA4uES+OZieQLZ3J81So2bPmjgrMQTB/ojkbnt0IWjAYJBr
         5EqPYfHNovDFbtH58U7xQT4lCqKSLz3XrplEb1q3wbQ0VIG4/fCuCzJVlvoeOKg6P6qF
         zqeGE/gZBeBrU2bh9oJqPg72XZwjTQ69LfsUm1JgF4Zzz8rFXnwDSbRby0LNmLIT+waF
         bw42fY1WD8xt/UUoDQOGs/zUk4/7LBnz2UqZuPNqhCPXbX+8v5MyYmESSbDFuC5QUZAJ
         ETug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760222997; x=1760827797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC+4EsZ1d3NIC8yIzm0IlzROUzmSGxGjCHMWgdrvoxg=;
        b=aOAoVWcyiT+NgfzZPpvlEzYDeZ9+W4l+az1eAWvhcyFkTCVsNzIg+jpeV55fjcybB1
         wgpByG888o46Rmcg8BZhpUKommy3nEYjempVNTjbnOs49bPHLUXDScnWvhq8La1bFX5w
         KYlSVGFMugJ2X2FXbRIxdLJwwSMICAoHVppaAaDpDuTcxu0vJOYJ7237rIPwzw7+8myv
         TBy1PQdM+BidPXVZ9Xu31RMZ1TA4hsHQ/Dp/7m9PUXpQobmHrvHaPhyVz07ppANgwXvq
         XgBtDmVKO8KvuxG58vkNpvU62m+TSj2mwCBAHypTzDsGqb4YQREybQDH6FmZ/0t4VklT
         fpDw==
X-Forwarded-Encrypted: i=1; AJvYcCUKqJSKc6eZGiL3oiUXqPrCehoc+UHqXvpmTefagMPm52rS5tTY39UITBKBTAd98nkdysN7KCaqzYzhE5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0BMWO+MrnA4Sj5m6x9I7FZAUxHp5yBqvTOW6O3ZgFdFIehzK
	3/qtBFSKirjPCrNtk1IqAoaLk9YSGiIYVC5co4gvdxehI27ZFmyXeS5K
X-Gm-Gg: ASbGncsYzF5tAZgS/+UAj3HtlNReYz6sIYUXagEEg2FDsdnTHmqgWkm2v7UcS6LlHJq
	sHx7VpWEE3uNRadEs9dbw1IdVsGIRxDsgq0KUwssNnA1Rz6KAAXF+Qh4paU50NTx8ML7xjAq76u
	+cmC7WtNE3cYHZr7CMx/9G6cAO0zlMwxp8/+CfMO8S2+H/n8T9WCHenqhvtEeTt+kpRqgDnXZud
	cJ6KQotRrDQC6Z7/gPXEcbQPXddjWUyoBE6v4dy0ubntPVCeRMKZ5DwQkLBjUjoHW/LwTUR+h0q
	kvwtZHRCQbuf9EXHkwxW//kRmPSuoOs+YBSVh7hbbjKYPBcgFJTchTGEdY0/abSo6ULJdbQushG
	BAG3GN89FfVoTyeDU3PPLYNc13RsaAcRDvku1DteVQ57xKb8gDc7eYppqF11E
X-Google-Smtp-Source: AGHT+IGvYFSuPhM9Dc3xwV6rXSKhQCtXeBrL3rUjFzXec28wWn3u3C23GFwzxdJzNvArdRj4U4Kh3A==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr110392035e9.36.1760222996639;
        Sat, 11 Oct 2025 15:49:56 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583424sm10575949f8f.21.2025.10.11.15.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 15:49:56 -0700 (PDT)
Message-ID: <ebc5ede8-cf00-47a3-8a78-d9475f42cf97@gmail.com>
Date: Sun, 12 Oct 2025 01:49:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 0/7] wifi: rtw89: improvements for USB part
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zong-Zhe Yang
 <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <88f30433-98fa-4f9a-bbe3-9d630b72c2e4@gmail.com>
 <20251011171303-6e37619c4071ee0bae4f9675-pchelkin@ispras>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251011171303-6e37619c4071ee0bae4f9675-pchelkin@ispras>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2025 17:57, Fedor Pchelkin wrote:
> On Sat, 04. Oct 20:37, Bitterblue Smith wrote:
>> I tested these patches with RTL8851BU, RTL8832AU, RTL8832BU, RTL8832CU, and
>> RTL8912AU. They all work, with a few additions.
>>
>> Before these patches RTL8851BU and RTL8832AU would remain "connected" when
>> I power off the router. That's because they don't have beacon filtering in
>> the firmware and the null frames sent by mac80211 were always marked with
>> IEEE80211_TX_STAT_ACK. With these patches they disconnect immediately when
>> I power off the router. So that works nicely.
>>
> 
> Glad to hear, thanks for the insight.
> 
>> What doesn't work is TX reports for management frames. Currently rtw89
>> doesn't configure the firmware to provide TX reports for the management
>> queue. That can be enabled with SET_CMC_TBL_MGQ_RPT_EN for the wifi 6 chips
>> and with CCTLINFO_G7_W0_MGQ_RPT_EN for RTL8922AU.
> 
> I'll investigate. Looks like the enabling of the management part should go
> to rtw89_fw_h2c_default_cmac_tbl().
> 

Yes, and rtw89_fw_h2c_default_cmac_tbl_g7().

> Btw, could you give a quick hint please on how I can check during testing
> that the reporting facility works properly for all cases needed?  By far
> I've dealt with iw utility and debugging printks incorporated into rtw89
> but it doesn't look sufficient anymore..
> 

I enabled RTW89_DBG_TXRX, which let me see that no TX reports appeared
during authentication and association. I also added a printk where the
IEEE80211_TX_CTL_REQ_TX_STATUS flag is checked. Then I just use the
driver normally, with wpa_supplicant and NetworkManager.

>>
>> The other thing that doesn't work is the TX reports are different for
>> RTL8852CU and RTL8922AU. It's only a small difference for RTL8852CU:
>>
>> #define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1 GENMASK(15, 10)
>>
>> RTL8922AU is more strange. It needs something like this:
>>
>> #define RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2 GENMASK(9, 8)
>> #define RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2 GENMASK(15, 12)
>> #define RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2 GENMASK(15, 10)
>>
>> The C2H is 80 bytes here (header included).
> 
> rtw89_mac_c2h_tx_rpt() needs to account for different types of C2H report
> formats, bah.  Will add this missing part.


