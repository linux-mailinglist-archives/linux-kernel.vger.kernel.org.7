Return-Path: <linux-kernel+bounces-642306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E3BAB1D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A58E1C25517
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC122AE59;
	Fri,  9 May 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jgjuaADv"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAD25394B
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817871; cv=none; b=i3uHD5ngEukdRGnEnZKSjClR3ubi9sjzCaScFvJ05YMEjfqB84Q9Iax6MjuIe8/r5/1soV7SXlahwWx5VIYtCqUr+jOPo8XmIg98gF/vnyTWQ1oHCpfwyGzuz919w18Gj6xh17EUrPHnSgE+4tP+V9TFNNcN7ZnUgTTS7EolFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817871; c=relaxed/simple;
	bh=3oFbcPq/LmpRi6imEmgZsdbNy/2ZZrBkRnQhQopsbAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldAR0X766UiUmt7JuM75JNuSRX4VB10Ruen8mFmFFH8Rz3uG/i0TF3cEhcHCwkfZgi96k4g4vlMrdbDQh4Ds56zbpj7m5cRJ5zn7GT0tXs40lj+LPCXXhUooO09H4XEqzBMZeT0MZFixVtkuzxErnkCLdet5WB1BnbkDqYxtdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jgjuaADv; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id DPB4u9czYiuzSDT7kuaCsT; Fri, 09 May 2025 19:11:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id DT7jusesMjrgqDT7juquKe; Fri, 09 May 2025 19:11:07 +0000
X-Authority-Analysis: v=2.4 cv=PK7E+uqC c=1 sm=1 tr=0 ts=681e534b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=dZbOZ2KzAAAA:8 a=stkexhm8AAAA:8
 a=GZsA4xnBWax8gLnPL8AA:9 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
 a=pIW3pCRaVxJDc-hWtpF8:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=unaJtBXX3ic/M7Mptke85HD19Mt1Q7wftiHK6u0Qhp0=; b=jgjuaADvBq5PnCf7F7GTxnqZqK
	TZM3oe/5n40OE1mBxnyCqZQFECwsTY5oe7I3uInDIzJinDph/28wo+bENu1lsvj2ppPwq5rf8Viyo
	OP1gsh8KmhTmLFIZ6VxZHhjF3YFJSaHpDS9CHZ4zv4c3+R6WReDbO8x44moCxD2zEf7tnTBt87DkJ
	9U5j15rvWJENBHeeFM+dl9XoKTTP2dM3IjFmTmuNV13FO6MBP3UDYW8CSFL3vJQdOhvoTpDhqEmdC
	v6U4J3TONYO/yIQQZc9ZyNfr/4Y8S/M4x/yY/Al5s7xUstGMGc4oy881wt1dtX1ImmlaEVsV2N0Uw
	tEVCyzmA==;
Received: from [177.238.17.151] (port=60388 helo=[192.168.0.102])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uDT7i-00000004KcA-0hDg;
	Fri, 09 May 2025 14:11:06 -0500
Message-ID: <12490f84-6b0c-41c0-9129-f02ccbeaa24c@embeddedor.com>
Date: Fri, 9 May 2025 13:10:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Set n_channels after allocating struct
 cfg80211_scan_request
To: Kees Cook <kees@kernel.org>, Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+4bcdddd48bb6f0be0da1@syzkaller.appspotmail.com,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250509184641.work.542-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250509184641.work.542-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uDT7i-00000004KcA-0hDg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.102]) [177.238.17.151]:60388
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAkl9B58Q00DaDpD9EimL/8zj3/zfvwAu/1DxIcCLVkoMML9XjmSQk4My/9K5lulJloYn9qsUXZVEA7bzePwhO/Nxi3G4irPsuyHHxPITv0Y9gu5uq/K
 bCPDa+nB5eYCUob+Oe2Y68/NMvHctaXjTSONlpEpoVeJ2Elmjc14MQi6ryqxDYmEjCJH20vzHheBhPb7+Ai7cmJJ8G6NM8xWmXIQ/VE7zAJMbolRdcyRMeVB



On 09/05/25 12:46, Kees Cook wrote:
> Make sure that n_channels is set after allocating the
> struct cfg80211_registered_device::int_scan_req member. Seen with
> syzkaller:
> 
> UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:1208:5
> index 0 is out of range for type 'struct ieee80211_channel *[] __counted_by(n_channels)' (aka 'struct ieee80211_channel *[]')
> 
> This was missed in the initial conversions because I failed to locate
> the allocation likely due to the "sizeof(void *)" not matching the
> "channels" array type.
> 
> Reported-by: syzbot+4bcdddd48bb6f0be0da1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/680fd171.050a0220.2b69d1.045e.GAE@google.com/
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Edward Adam Davis <eadavis@qq.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: <linux-wireless@vger.kernel.org>
> ---
>   net/mac80211/main.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 741e6c7edcb7..6b6de43d9420 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1354,10 +1354,12 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   	hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_MONITOR);
>   
>   
> -	local->int_scan_req = kzalloc(sizeof(*local->int_scan_req) +
> -				      sizeof(void *) * channels, GFP_KERNEL);
> +	local->int_scan_req = kzalloc(struct_size(local->int_scan_req,
> +						  channels, channels),
> +				      GFP_KERNEL);
>   	if (!local->int_scan_req)
>   		return -ENOMEM;
> +	local->int_scan_req->n_channels = channels;
>   
>   	eth_broadcast_addr(local->int_scan_req->bssid);
>   


