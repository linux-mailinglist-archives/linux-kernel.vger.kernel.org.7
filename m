Return-Path: <linux-kernel+bounces-788010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E975B37EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7710C364FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77101343213;
	Wed, 27 Aug 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="yqU6RZhX"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63888276028
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286736; cv=none; b=PklqYGeNvStO57PDLwtwWHhNvI0c9Z/PIrwBBt40ybRUJNj6v88ubbtgx5ERezWaf6zJ0FuQDk8oQLKfKxJtdeWdGWL/MvGv/lyMt42diNIdWU1iG2tJj1yyLmtI/CLdt5NPIpP8rR/zCX3i5JdapdpxwTeMY9IwjUYJJw/Af9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286736; c=relaxed/simple;
	bh=oMi0UWQ+TOt6JL8ZYf2QKRNR+60rZGf59phnokJPm48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwTPT1bNx3wB7fm5+QcCcWFtutBB49YllwLmH5Psr++2VO4IjQzZFl0VaFH6ZSWDXekiKIVWxU5H5gl3LJUC8V3K4kxUlVpDAepTTQRCmKQNsFympXxKcv16JSw4GajLcfsZ2YEdTdVYBqOc+2F+gYwR36vJYc+5MKsIS/JRL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=yqU6RZhX; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id rCGXuFHHrrrvprCPOus46F; Wed, 27 Aug 2025 09:25:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id rCPNueiMLgtDgrCPOu9KrF; Wed, 27 Aug 2025 09:25:34 +0000
X-Authority-Analysis: v=2.4 cv=NrbRc9dJ c=1 sm=1 tr=0 ts=68aecf0e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DR2cKC/DEnBA9KqqjaPhpA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=EQ2wRRerX22KNVu84O0A:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QKXC/+BbZZkDCTwUOx2ABG7PtIdtlD0aC6xcaPGqrKc=; b=yqU6RZhXp/xD+WohzkCZ6Tp6jj
	wryf1jbLDHn4ylufsEKINPRbBuS/rBP1XH7816YtP6xS49B6ofxGmQYT9AIT4b/NgYEwKQBHmUEGp
	FUvP6GKAJ4DeqXxgLjDe0oabrisMLNds/b4Qd6Gv5qi3jG53F05wLIsNe3lkIS5gyoCC0vOojTU5s
	9Uht93L5O7NaqJXWwQ9DRgESj7ZcxdU8ufave6CZde2GZkuF3gZ13FqH1t1RUumYlCvq0s5X7RRoo
	RbUco1dvaM4BJ9tQzhlsy5OkvqEqNE7BvKTrBn75wi35GYq7dNSryT8+3+oT10a41Gz5zyRJUyhPG
	AisQyeQw==;
Received: from static-243-216-117-93.thenetworkfactory.nl ([93.117.216.243]:44652 helo=[10.94.27.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1urCPM-00000002geJ-3JG4;
	Wed, 27 Aug 2025 04:25:33 -0500
Message-ID: <e0aeda2d-931c-49c6-b0d4-dd097e87eae6@embeddedor.com>
Date: Wed, 27 Aug 2025 11:25:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iwlegacy: Remove unused structs and avoid
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aJl7TxeWgLdEKWhg@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aJl7TxeWgLdEKWhg@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 93.117.216.243
X-Source-L: No
X-Exim-ID: 1urCPM-00000002geJ-3JG4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: static-243-216-117-93.thenetworkfactory.nl ([10.94.27.44]) [93.117.216.243]:44652
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJJop/0+aYIsx8V24oauR9YMHkm/e4LqhLqIr5Z2OLA9cJxpWC2gRTfDH/3igsw27BeUtjXmA7/qZbh1YJ2zBcEF9tJ59GwXUcTYkbHoglXk0LQ6ZIK4
 qrXs9zZ9jvRu/AfLwT1V9q62dolawb2E+/fuKFXNQZGcxHFQVEXz5O/NxzaBrhCzCRYR/ju/d1J2T5ZP79BgLYIoayo1fvfgVhIUnDC0t1I0RTkPtzO1Kmcw

Hi all,

Friendly ping: who can take this, please? :)

Thanks!
-Gustavo

On 11/08/25 07:10, Gustavo A. R. Silva wrote:
> Remove unused structures and avoid the following
> -Wflex-array-member-not-at-end warnings:
> 
> drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h:68:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h:60:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   .../wireless/intel/iwlegacy/iwl-spectrum.h    | 24 -------------------
>   1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> index 1e8ab704dbfb..f00eb878b94b 100644
> --- a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> +++ b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> @@ -50,28 +50,4 @@ struct ieee80211_measurement_params {
>   	__le16 duration;
>   } __packed;
>   
> -struct ieee80211_info_element {
> -	u8 id;
> -	u8 len;
> -	u8 data[];
> -} __packed;
> -
> -struct ieee80211_measurement_request {
> -	struct ieee80211_info_element ie;
> -	u8 token;
> -	u8 mode;
> -	u8 type;
> -	struct ieee80211_measurement_params params[];
> -} __packed;
> -
> -struct ieee80211_measurement_report {
> -	struct ieee80211_info_element ie;
> -	u8 token;
> -	u8 mode;
> -	u8 type;
> -	union {
> -		struct ieee80211_basic_report basic[0];
> -	} u;
> -} __packed;
> -
>   #endif


