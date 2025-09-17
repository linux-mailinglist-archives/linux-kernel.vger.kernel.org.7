Return-Path: <linux-kernel+bounces-820053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCFAB7D429
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D4246257C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2CB27A91D;
	Wed, 17 Sep 2025 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="e/co/shn"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB51EFFB4;
	Wed, 17 Sep 2025 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090216; cv=pass; b=kNgMP8IsadTI03R946GYgRz0uIkZGcyyFcfcHGX9t1vG3mwDzF3Vtw3jg4rhK4TuewEWIU5GLQFCwEmBt7WCYM85Mkn0dc4UBDuIsUhbCugaE3u3NVtjNRaLWibaa/c05PoiEvCdTc1nkbFh7OKqklkk9xVUFk1Ku6CSTGzodMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090216; c=relaxed/simple;
	bh=ndBxuU9IcHR03Y9HLWlRv5Q/Odxh43haWkbb9IzLfeY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IzybP6DdpfO5DcojYF4O6DCqZsTeiBcvQ/cXIFyq3xZbiv7uHQctFebRfmJ1puaRul7tLbm2OvaJjB0uuDl4JljOZ+izMCfVEl86m8747NZxyfvB1w5F6Z2srCPBO8YxxpEGyqp34O3N4byvYvWumdQs0hnkZSO9iwA8zxRJt5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=e/co/shn; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58H6NMfx025691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 17 Sep 2025 15:23:22 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 4F71110004001;
	Wed, 17 Sep 2025 15:23:22 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ztiYt9BY-MHE; Wed, 17 Sep 2025 15:23:18 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 96231107E4935;
	Wed, 17 Sep 2025 15:23:18 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 96231107E4935
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758090198;
	cv=none; b=nU7vdU827dz4WRutJl1Fcc76g5R2AIFAlqEV8LBw2Il0DgVsS75jG/efa3XfwDgZutI3BydJ8x6885Lsfqc42o0YDuzOUlskw6wqPJYKFU+MMf7j7p4PS7Vo14jsY7/GzdsZUt3LHgKpY9BHI1u9MK7LQTw0BMg/r2z8wYJc+tA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758090198; c=relaxed/relaxed;
	bh=+GrXQLi8JzGKGwFdNWSSKJ/huT3Qx+bd/EKJ8GlEDP8=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=R02eEnmMdTyavA3U2OlCiVvva7LWCKK7hg0u9P1l56KXRR/FddKRj0Qhn3H2XPsJBqMTlOlzfwXzO/TNmJUBU8Zu/NUcdLIudbXFGAOPQZ+dQrboyt8mxs1lhx547YNTNSx7S5Kk+MTOAF8+KpxE9NRqw+Mrzc6G72wE80u6c7k=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 96231107E4935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758090198;
	bh=+GrXQLi8JzGKGwFdNWSSKJ/huT3Qx+bd/EKJ8GlEDP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e/co/shnraooVzUmuPLKj24bJBFUpp+YqM3kdie0zem5Q6Ce2wpS9KFFAco5sQEgj
	 d69dm0FrAylIA30O9V//lPapsPLPRQrZkRfHP7/OydNNpZOhMP3nb9+bAb6+OJsrVY
	 MI3x7fBslA5E5fssylJwVZ75v+vt1vlWBEXQdlGg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 15:23:18 +0900
From: weibu@redadmin.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: xmit: fix grammar in comment
In-Reply-To: <2025091705-murky-sage-465f@gregkh>
References: <20250917053944.1447050-1-weibu@redadmin.org>
 <2025091705-murky-sage-465f@gregkh>
Message-ID: <2a4eef3ad872c923be7b0070056b5a8b@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Thanks, Greg.

Sorry for the off-list reply; resending to the lists.
You're right about the extra space; I dropped it. To avoid the "number 
of"
confusion I rephrased the sentence to "Total page count is not 
available, so
update current FIFO status." Sent as v2.

Best,
Akiyoshi

2025-09-17 14:52 に Greg KH さんは書きました:
> On Wed, Sep 17, 2025 at 02:39:44PM +0900, Akiyoshi Kurita wrote:
>> Fix 'number of page' -> 'number of pages' in a comment.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>>  drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c 
>> b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
>> index 842e19b53421..7ba8981f4652 100644
>> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
>> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
>> @@ -76,7 +76,7 @@ static s32 rtl8723_dequeue_writeport(struct adapter 
>> *padapter)
>>  	/*  check if hardware tx fifo page is enough */
>>  	if (!rtw_hal_sdio_query_tx_freepage(pri_padapter, PageIdx, 
>> pxmitbuf->pg_num)) {
>>  		if (!bUpdatePageNum) {
>> -			/*  Total number of page is NOT available, so update current FIFO 
>> status */
>> +			/*  Total number of pages is NOT available, so update current FIFO 
>> status */
> 
> As "pages" is now plural, shouldn't "is" become "are"?
> 
> Also, you can drop the extra leading space in the comment.
> 
> thanks,
> 
> greg "english grammer is rough" k-h

