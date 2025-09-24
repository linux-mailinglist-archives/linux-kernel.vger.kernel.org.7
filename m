Return-Path: <linux-kernel+bounces-831136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50E4B9BA68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3911316F809
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1013F25B31B;
	Wed, 24 Sep 2025 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R45zdsHl"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383151ADFFB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741410; cv=none; b=t887DWpV9YlMchgRj6O8bskaPsU+UMLaRxqdQH09PuCvOnKC4ioJJAr/y4WlO4iZFTDh8GJgvXZh4NnLoHuJssh3Fzl3O8eMydtkArLAOwXj1G56LIjJwGu9wKaxTUiI5BtzdEJ8gz5ckYKFGYAId2JQzWbe88mS7JpIculfe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741410; c=relaxed/simple;
	bh=YVlT54garPBD0FO2+bAXLOKliKfzm/96L/8qJaEhjbQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EsCn6CUkzS3hHJr/nI1WhBCcw2bKzARgtkLoMQEnibh27DzdrGSb8a0TpymhWstk5MgnrkVBqcZE7ny/w9Xc77pw1u7gcJuLbZdt5OKTzHZWmYUIFwb7VgHFqpdWf1+7FlHjQHh+1XqdZyemZZiUJ5iWWQGA+3VR8zv2ww2Hb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R45zdsHl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee130237a8so150805f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758741406; x=1759346206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WGx3zlBBHkNessJ0m/rkeDNiqfi2ciQeFSjApbhvzeI=;
        b=R45zdsHlhW2m7bUWki9EbupS43pZK2YS+XNfKSbuRMrwXV+zKZikHOBntel/W2MhWj
         HmuttDl1eP9aDJ38GKPCmnUzawuCeiG7p1myqYyn48ede61RO9VjLuPQuMhcXb3J0AmY
         ppH4SM++F6UxTwO3pgpL0bOY3F7EanLw/igNyN+ss+BAU/DsIdbfavJVEQrqxPmQG9jX
         W9Cwd5txHu4RusUdUzOPHgFyvvY9PS5TLbLaSSmFmtQA3La/uC/nBr1psBVwEKMAYNve
         HI7MkuYVzPrxbpcwv3mNNB0WZlDffKeQFzJCGi6zr/6QlzUK1EdnzGaKBuKO7Q+anLVd
         jW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758741406; x=1759346206;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGx3zlBBHkNessJ0m/rkeDNiqfi2ciQeFSjApbhvzeI=;
        b=PMCT6ymeFbrjRZuhr/BFsVxuSGqt2p8Mi/ZYovD0JnBU2fUN5mJ9CSktjRGtuvEFhj
         iGPtcDZwsdkwhRC1NstrKzv3Djc4J7HSHImNsgraRUsyLEMVr3pAtCTocdU0Dh3Bj7c+
         rAa6cVAmI7tfpN/ly3qxB867sCtf3EGTK9MNjz1eBzVo9dX2pPMep+sHj2csN4KCWHmV
         9TlPZjyGQTpUWasscxvr3fKgRKiI6au8Ks9jmdEpjp1Q+79JiHtwgrbZHF37cWwnl+RR
         coudeIGKfn5D39Y3pk2Sh1fav01/3uFRn1jfMnmZ5oj6MgyhrCQsJPrRjyKJK+JPPPfr
         Wn3g==
X-Forwarded-Encrypted: i=1; AJvYcCWSJwyCR7ylM7y0GNO0oBro2xlWbPPfdL+6PYilooogo4UxgkDf4tRaPG+KBKKFKvh0AVVUY/VUaqYFhtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznJhXL/PxSuMJlhbSAKXtv/qxmOnhA1KkSvI3m+iLWLwJo70qo
	h4x0UbkFGt4IG/BYBlDLF51LP+BtJvpgKEs+3r2Fb0oWzoUCl3hqXUQJ
X-Gm-Gg: ASbGncv9rti+UC6lnUT79MiPd1EnxlJT5XPs332F8kKJqH0nWAZUm4W3UBOWwtKflgQ
	bfGkGkUTPDkxCs5p1ls4nKEL1CmfNgk9sgq8RJyo3EgH5YvdHioa0f2SCkQmfRCyLTtO1mioxvj
	rN98YhcqG5G8RqllDvRvmvzj+7P47Mwf4/y8sIy4Mq4Fs27d+9cRA69LdA02AMZaVVPGFims+35
	mpx5ccIKJgY4xcVOVqaXwZlAnsyHc4Eb8XapZozD2o5P/A9wpEWHDYQzlHPuCfPxWltdJovxdo2
	MTbnTz2n3vyMbczlAz28jD6xfHgIzoTVpCXNeHi7qnLNwi8z94c++nersOB/dYdt2NF+XwUvVQo
	mroS8e2am20/YFTyukFYpgYS/ZHod
X-Google-Smtp-Source: AGHT+IEkmum6L+0ojuHXcWkPL4nJbsrtJLZN+RK5tA0W3rkL3CZoiSWqcMwEBXIQ0fuk2YRFA2vAwQ==
X-Received: by 2002:a05:6000:40df:b0:3ea:c893:95a7 with SMTP id ffacd0b85a97d-40e4adce88amr837149f8f.31.1758741406208;
        Wed, 24 Sep 2025 12:16:46 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm30282797f8f.14.2025.09.24.12.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 12:16:45 -0700 (PDT)
Message-ID: <07ee4e8c-bcb8-4349-afd3-59bc58899116@gmail.com>
Date: Wed, 24 Sep 2025 22:16:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 3/6] wifi: rtw89: implement C2H TX report handler
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, Po-Hao Huang
 <phhuang@realtek.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-4-pchelkin@ispras.ru>
 <5316222e-5d9d-4cb8-b161-06ba311bdc2d@gmail.com>
Content-Language: en-US
In-Reply-To: <5316222e-5d9d-4cb8-b161-06ba311bdc2d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/09/2025 01:12, Bitterblue Smith wrote:
> On 20/09/2025 16:26, Fedor Pchelkin wrote:
>> rtw89 has several ways of handling TX status report events.  The first one
>> is based on RPP feature which is used by PCIe HCI.  The other one depends
>> on firmware sending a corresponding C2H message, quite similar to what
>> rtw88 has.
>>
>> Toggle a bit in the TX descriptor and place skb in a queue to wait for a
>> message from the firmware.  Do this according to the vendor driver for
>> RTL8851BU.
>>
>> It seems the only way to implement TX status reporting for rtw89 USB.
>> This will allow handling TX wait skbs and the ones flagged with
>> IEEE80211_TX_CTL_REQ_TX_STATUS correctly.
>>
>> Found by Linux Verification Center (linuxtesting.org).
>>
>> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>> ---
>>  drivers/net/wireless/realtek/rtw89/core.c | 12 +++++++++++-
>>  drivers/net/wireless/realtek/rtw89/core.h |  2 ++
>>  drivers/net/wireless/realtek/rtw89/fw.h   |  5 +++++
>>  drivers/net/wireless/realtek/rtw89/mac.c  | 23 +++++++++++++++++++++++
>>  drivers/net/wireless/realtek/rtw89/mac.h  |  9 +++++++++
>>  drivers/net/wireless/realtek/rtw89/txrx.h |  2 ++
>>  6 files changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
>> index 917b2adede61..d2a559ddfa2e 100644
>> --- a/drivers/net/wireless/realtek/rtw89/core.c
>> +++ b/drivers/net/wireless/realtek/rtw89/core.c
>> @@ -1420,11 +1420,20 @@ static __le32 rtw89_build_txwd_info2_v1(struct rtw89_tx_desc_info *desc_info)
>>  	return cpu_to_le32(dword);
>>  }
>>  
>> +static __le32 rtw89_build_txwd_info3(struct rtw89_tx_desc_info *desc_info)
>> +{
>> +	bool rpt_en = desc_info->report;
>> +	u32 dword = FIELD_PREP(RTW89_TXWD_INFO3_SPE_RPT, rpt_en);
>> +
>> +	return cpu_to_le32(dword);
>> +}
>> +
>>  static __le32 rtw89_build_txwd_info4(struct rtw89_tx_desc_info *desc_info)
>>  {
>>  	bool rts_en = !desc_info->is_bmc;
>>  	u32 dword = FIELD_PREP(RTW89_TXWD_INFO4_RTS_EN, rts_en) |
>> -		    FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1);
>> +		    FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1) |
>> +		    FIELD_PREP(RTW89_TXWD_INFO4_SW_DEFINE, desc_info->sn);
>>  
>>  	return cpu_to_le32(dword);
>>  }
>> @@ -1447,6 +1456,7 @@ void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
>>  	txwd_info->dword0 = rtw89_build_txwd_info0(desc_info);
>>  	txwd_info->dword1 = rtw89_build_txwd_info1(desc_info);
>>  	txwd_info->dword2 = rtw89_build_txwd_info2(desc_info);
>> +	txwd_info->dword3 = rtw89_build_txwd_info3(desc_info);
>>  	txwd_info->dword4 = rtw89_build_txwd_info4(desc_info);
>>  
>>  }
>> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
>> index 928c8c84c964..2362724323a9 100644
>> --- a/drivers/net/wireless/realtek/rtw89/core.h
>> +++ b/drivers/net/wireless/realtek/rtw89/core.h
>> @@ -1167,6 +1167,8 @@ struct rtw89_tx_desc_info {
>>  	u8 ampdu_density;
>>  	u8 ampdu_num;
>>  	bool sec_en;
>> +	bool report;
>> +	u8 sn;
>>  	u8 addr_info_nr;
>>  	u8 sec_keyid;
>>  	u8 sec_type;
>> diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
>> index ddebf7972068..f196088a8316 100644
>> --- a/drivers/net/wireless/realtek/rtw89/fw.h
>> +++ b/drivers/net/wireless/realtek/rtw89/fw.h
>> @@ -3747,6 +3747,11 @@ struct rtw89_c2h_scanofld {
>>  #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
>>  	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
>>  
>> +#define RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h) \
>> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 6))
>> +#define RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h) \
>> +	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(12, 8))
> 
> This is only 4 bits:
> 
> #define TXCCXRPT_SW_DEFINE_SH		8
> #define TXCCXRPT_SW_DEFINE_MSK		0xf
> 
> 
> The rest of the series looks good to me. (I don't know much about
> the RCU stuff.) I will test this tomorrow.
> 

Actually, I found this in my notes:

"how to get just one tx report for each request? currently it seems
to provide a report for each transmission attempt. how is the vendor
driver coping with that?"

I think your code doesn't account for this.

Sorry I forgot about this detail. This behaviour is new in rtw89.
The chips supported by rtw88 provide only one report for each request.

>> +
>>  struct rtw89_mac_mcc_tsf_rpt {
>>  	u32 macid_x;
>>  	u32 macid_y;
>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>> index fd11b8fb3c89..01afdcd5f36c 100644
>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>> @@ -5457,6 +5457,17 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
>>  	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
>>  }
>>  
>> +static void
>> +rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
>> +{
>> +	u8 sw_define = RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
>> +	u8 tx_status = RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
>> +
>> +	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
>> +		    "C2H TX RPT: sn %d, tx_status %d\n",
>> +		    sw_define, tx_status);
>> +}
>> +
>>  static void
>>  rtw89_mac_c2h_mrc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
>>  {
>> @@ -5691,6 +5702,12 @@ void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
>>  	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
>>  };
>>  
>> +static
>> +void (* const rtw89_mac_c2h_misc_handler[])(struct rtw89_dev *rtwdev,
>> +					    struct sk_buff *c2h, u32 len) = {
>> +	[RTW89_MAC_C2H_FUNC_TX_REPORT] = rtw89_mac_c2h_tx_rpt,
>> +};
>> +
>>  static
>>  void (* const rtw89_mac_c2h_mlo_handler[])(struct rtw89_dev *rtwdev,
>>  					   struct sk_buff *c2h, u32 len) = {
>> @@ -5777,6 +5794,8 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
>>  		}
>>  	case RTW89_MAC_C2H_CLASS_MCC:
>>  		return true;
>> +	case RTW89_MAC_C2H_CLASS_MISC:
>> +		return true;
>>  	case RTW89_MAC_C2H_CLASS_MLO:
>>  		return true;
>>  	case RTW89_MAC_C2H_CLASS_MRC:
>> @@ -5812,6 +5831,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>>  		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MCC)
>>  			handler = rtw89_mac_c2h_mcc_handler[func];
>>  		break;
>> +	case RTW89_MAC_C2H_CLASS_MISC:
>> +		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MISC)
>> +			handler = rtw89_mac_c2h_misc_handler[func];
>> +		break;
>>  	case RTW89_MAC_C2H_CLASS_MLO:
>>  		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MLO)
>>  			handler = rtw89_mac_c2h_mlo_handler[func];
>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
>> index 25fe5e5c8a97..632b85aed032 100644
>> --- a/drivers/net/wireless/realtek/rtw89/mac.h
>> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
>> @@ -432,6 +432,14 @@ enum rtw89_mac_c2h_mcc_func {
>>  	NUM_OF_RTW89_MAC_C2H_FUNC_MCC,
>>  };
>>  
>> +enum rtw89_mac_c2h_misc_func {
>> +	RTW89_MAC_C2H_FUNC_WPS_RPT,
>> +	RTW89_MAC_C2H_FUNC_TX_REPORT,
>> +	RTW89_MAC_C2H_FUNC_BF_SENS_FEEDBACK = 0x4,
>> +
>> +	NUM_OF_RTW89_MAC_C2H_FUNC_MISC,
>> +};
>> +
>>  enum rtw89_mac_c2h_mlo_func {
>>  	RTW89_MAC_C2H_FUNC_MLO_GET_TBL			= 0x0,
>>  	RTW89_MAC_C2H_FUNC_MLO_EMLSR_TRANS_DONE		= 0x1,
>> @@ -470,6 +478,7 @@ enum rtw89_mac_c2h_class {
>>  	RTW89_MAC_C2H_CLASS_WOW = 0x3,
>>  	RTW89_MAC_C2H_CLASS_MCC = 0x4,
>>  	RTW89_MAC_C2H_CLASS_FWDBG = 0x5,
>> +	RTW89_MAC_C2H_CLASS_MISC = 0x9,
>>  	RTW89_MAC_C2H_CLASS_MLO = 0xc,
>>  	RTW89_MAC_C2H_CLASS_MRC = 0xe,
>>  	RTW89_MAC_C2H_CLASS_AP = 0x18,
>> diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
>> index 984c9fdbb018..d7259e6d798e 100644
>> --- a/drivers/net/wireless/realtek/rtw89/txrx.h
>> +++ b/drivers/net/wireless/realtek/rtw89/txrx.h
>> @@ -139,8 +139,10 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
>>  #define RTW89_TXWD_INFO2_SEC_CAM_IDX GENMASK(7, 0)
>>  
>>  /* TX WD INFO DWORD 3 */
>> +#define RTW89_TXWD_INFO3_SPE_RPT BIT(10)
>>  
>>  /* TX WD INFO DWORD 4 */
>> +#define RTW89_TXWD_INFO4_SW_DEFINE GENMASK(3, 0)
>>  #define RTW89_TXWD_INFO4_RTS_EN BIT(27)
>>  #define RTW89_TXWD_INFO4_HW_RTS_EN BIT(31)
>>  
> 


