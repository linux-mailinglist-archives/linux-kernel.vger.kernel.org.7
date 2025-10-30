Return-Path: <linux-kernel+bounces-879140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF2C225DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B760B3BC9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99426334368;
	Thu, 30 Oct 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMR38vdG"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07D3271F8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857807; cv=none; b=qWXzJriPeGxqFDHRllIwX0CJI5qE2aMMGXsy1/SKiJsXGYLSnEbqUyh9LzRauzD3L8o/9cc+l55yqMoaDiXQHxlu2vR1CWT7JJTWqCOjaaZp14i7sHot0+hReG2Fbqxj6m1oXAP03mRMRtmD/mCoZWjqfZ/szBnS7tHfyJhmRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857807; c=relaxed/simple;
	bh=fxzHzvWmdAWF9UbkLRstIMnm/pjLnvQZZYgOkEGuKts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idHo9Vqn2Ezw39NKhX7hU1kcWoNq3+NX3MNTuaG3moS/gEBfnAibhZX/5Le1OgyHMqKSMHOqih63fF/76JOJOsDOomZjXT2lm/uutVIjLT4RN//CZUJLtQj1Aq7DkfDgPsvUL4c7vXVN3vnIPsgiiQu6XBDWcNt3/WneSGCibos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMR38vdG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so11360565e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761857804; x=1762462604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1IYoFNZViqG3+neMlVS5maG2t/OQB3EUHGZRJTfzmE=;
        b=OMR38vdGpIlaZ+LrCXuQJdureydNdXDo7N+RXkGRwxH3xIeroT5Sxk7zBRAnAEmEek
         h3MdJaQ/UB2emKfmgswp+sNFatXk77TIfpgaTzLedP9XQ0C96WVYLFJ3m47fs5PVCbW8
         M/MQFMMYwE0SiQXzvXWSTyichBEQ2SPePdce6Rs8A7lFRYHRhCpV/EbQ+0fxYwBlE52+
         ge/s0WZ8WLslKlqHRyDa8ZVU6dUUvP5Oa/i0VmiHcQF1gsUPcEQglQYyKK/zkqlWK2Dh
         tLMM+HF85xehLKqZ7ER3eGzoktXh50pBurN5TrPi7klbJTJEjxEZb5BUS+Ozvz/NPzjn
         PuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761857804; x=1762462604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1IYoFNZViqG3+neMlVS5maG2t/OQB3EUHGZRJTfzmE=;
        b=pCPoBBvInq2NIuBbmFCtk0AcnU1avbVuPk6sBCZ8IlxMsHxyPXr5oB+csGmky8TDfB
         Qv0O3WcsYNYbUBzq9ERJLcXi74nSkajYdFCFo2asukzWsttCafRHry51Ra5BLT9L+Vt0
         KrKcqTgthmtviXCzZaolgRAEueXg3Sawkj6UQ5X7Azd7pB5bsahTf+A097I11zQaI9xE
         VlAwaV0ZclJw3vpbqUaLTmOf02pJZWqpqDQj3p1eeHZr6Qf/eiG8FI8Knu+PduyRid0X
         lG8bUbcGGNhZoKVTRStl8XKj34HDiQ34DPb8sJFjopNNxuqvJpZTMcYdaw9skMPxa2QM
         0j5w==
X-Gm-Message-State: AOJu0YxB5OvQkaJBHzzleZAmrboNzjlCnahzRY6CEwiAvzuaDT90aMjd
	iItEWJC99t04x6lW2pJbs169Mu0EDvEXob2eBzEuW+ORm3T63bb+WKwDAzaAjg==
X-Gm-Gg: ASbGnctJc2J6D/fZqr8CuPvmahxD0cePAm5YdQAslZyNktywIrNxTw9Zxjm/IH+5vYt
	6Cnx4B/6rTkv9GIaGpbPLnXoLqHAUxtM8KzptzdC8pmfMnirqplAZiFVU60scpBBv7w+Zz3xsAb
	F/ni4P+NSoyKtn9qurlBUgxmkb7la06KSUVq1SdSXOVKpShP1ScgzTVZ34qK/VmAOta8eUMQymK
	eKYLiEi+HubXmTqq1GNGlAse8e+Ndwmla8+mUytSE6ujXtPx6VXckRqQaEpV+r7LJUpVEcKDOiX
	n6d8JDx4HVGBboLV8DQp+zFIFqkGrxxZHWJSb73Nn4A1H8U9rfCb+HsZZM+0oJ6NLdddOqg/m8y
	3uwUj2aaeCC2ESph1/sY1WYZr+TYuRPp9BavYDHSABOK/uwDj1tT+6xaXYMcSVmM88yNlOFmGoH
	GWyHzMNNLyVckkK3ELr8HSFlH4BZ8vx5GdW0psUMPVCw==
X-Google-Smtp-Source: AGHT+IHX2moKE9C6Z94IEtZ1M0+4hm1FslNqxKw1NsLBgrzUtXLI6Qu28AGkyuUYJxFk3sCIvdb8zQ==
X-Received: by 2002:a05:600c:3146:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47730802df6mr10462865e9.4.1761857803455;
        Thu, 30 Oct 2025 13:56:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm6747435e9.6.2025.10.30.13.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 13:56:43 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:56:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Cc: linux-kernel@vger.kernel.org, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: maple_tree.c:3738:1: error: the frame size of 1040 bytes is
 larger than 1024 bytes
Message-ID: <20251030205641.47b2241f@pumpkin>
In-Reply-To: <aee90be9-4816-592e-632b-21cbea4bb3dd@nerdbynature.de>
References: <769dc761-3ea6-76b9-d6a3-cd64a3fddfe3@nerdbynature.de>
	<20251030143400.09fc0a89@pumpkin>
	<bb105b91-1f11-0a2b-a666-6ee72f86d989@nerdbynature.de>
	<20251030165137.56eb618f@pumpkin>
	<aee90be9-4816-592e-632b-21cbea4bb3dd@nerdbynature.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 18:13:33 +0100 (CET)
Christian Kujau <lists@nerdbynature.de> wrote:

> On Thu, 30 Oct 2025, David Laight wrote:
> > It is horrendous - best part of 4k code, the stack frame is 0x408.
> > Which means I must be building with a larger stack frame limit.
> > Is one of your debug options reducing it?  
> 
> No that I know of. I've attached the config to my initial posting.
> 
> > OTOH it looks as though the actual place to force a stack frame 'break' is to
> > stop mas_rebalance() and mas_split() being inlined into mas_commit_b_node().
> > (Probably instead of all the current noinline_for_kasan.)
> > Both those functions are large and don't have many parameters.  
> 
> Cool, that helped! Leaving mas_wr_bnode() as it was, and only changed:
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 39bb779cb311..949fd2a0554b 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2746,7 +2746,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
>   * Rebalance two nodes into a single node or two new nodes that are sufficient.
>   * Continue upwards until tree is sufficient.
>   */
> -static inline void mas_rebalance(struct ma_state *mas,
> +static noinline void mas_rebalance(struct ma_state *mas,
>  				struct maple_big_node *b_node)
>  {
>  	char empty_count = mas_mt_height(mas);
> @@ -2967,7 +2967,7 @@ static inline bool mas_push_data(struct ma_state *mas,
>   * @mas: The maple state
>   * @b_node: The maple big node
>   */
> -static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
> +static noinline void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
>  {
>  	struct maple_subtree_state mast;
>  	int height = 0;

Someone really ought to look at that code though.
1k stack frames tend to indicate 'sub-optimal' coding.
Especially since there are several 'rep stosd' to zero 64byte items
and an inlined (unrolled) copy of two larger on-stack structures.

I've implemented a balanced tree in the past, I don't what to try and
work out how a 'maple tree' is expected to work.
But the sheer amount of code makes be think there are better ways
to do things.

	David


> 
> > Oh, and the WARN_ON_ONCE() in there is all wrong.
> > A WARN_ON_ONCE(type != wr_split_store) after the call to mas_rebalance()
> > might make sense.  
> 
> I'll leave that for someone else to fix :-)
> 
> Thanks,
> Christian.


