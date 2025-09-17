Return-Path: <linux-kernel+bounces-821467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E9B81513
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534213A2753
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D593009ED;
	Wed, 17 Sep 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="p6PaIdY0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnKmc77x"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2B3002DC;
	Wed, 17 Sep 2025 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132894; cv=none; b=qXPwjAigEavOP04FJLuGgWrI1pJWlvNrcAYl7DJypHTyJrvc0zpYoJXPmLziDETEghQHiTE5oQMC4lb8L1C7OeMaBn8+VSFLS13TuwffnkmjMJ0ba/QiEkF4zWCCgO+OZzsG/qJHTcueKTylB5XSYtZuyS9WBvMFvx9lllyK1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132894; c=relaxed/simple;
	bh=DRfMQ6ZS5Y4IL68OG+ibUygGa1amCNHtUS5WiXxj2l4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B4ZxNQn/+2bxwoHU6OHWYgsBkezvjUFJHXXSE/Lgn7tpPLGzcPnBUkymG8JUaTqccE5etRYbQUJbuONlOAR1nIv7SCFl0atmV4zrxJ5tqiyiiAu09P4giH181VYcyad/5/gdhATmCHjPU+bPqcY0EwKhBc/W9uqnMkqR8HpC+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=p6PaIdY0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HnKmc77x; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 517487A01FF;
	Wed, 17 Sep 2025 14:14:50 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Wed, 17 Sep 2025 14:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758132890;
	 x=1758219290; bh=NKd86fh+V3u1uW6+QmnAIXTazO84hlGWvmMqSbkER8U=; b=
	p6PaIdY0T0iuH8+W/sLqjMrnH+RbrYAFQssb9yP9u+zy8n9eNFJnw0sgmyUM0QlZ
	xwvVsWl8A/8YU5IDudCb39FgJ7xcaYFXOIl++QY1Z5FrQJ7m3MZgFUylM57Aa7AL
	zRuMc2oA+KHjTr02HaXcn80L/8LLz/ciy6v4R9MsWrJkKz9o8nsr+oj0qP+H1oY0
	y87Chs1gY1D3e9FmSjYlaAkiLqk3CAZfwgpRXRMebqsgA6Ie1xQvT9mIpt+jXlWt
	wgvnxEukq0Zo8AMyaSMGTYBxNILS10tcc6U2HB13pwILhmHbH9pIKLfut1D0b/GZ
	JlJzemJU7ic85svRq0mwLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758132890; x=
	1758219290; bh=NKd86fh+V3u1uW6+QmnAIXTazO84hlGWvmMqSbkER8U=; b=H
	nKmc77xuwd8mgUHAn0unY5felP/5epuC213kweEdTUT6F/e0XaB+iqi/qe9DlSX3
	KPIfp4OnGf+YbM+hclem/BDdi54ruQAmqEedFzXeZZf1ptzphHjL01DRP22GXnD6
	el+pMaQNMxrtWy6k+sqWfZgs6arpgOktWCepJVp1xcG78tl9/iLnLn2woIGHBrAp
	LXrX1W6WaClG16HnsiuUAH2Rfy1Wz/GMEyh3O0F/XGc6PqqQgT/627YRAQjXfwLI
	AfiSApcKysaWZOidUm0E2von4nCK+iWmDbXwW+JeGG7KzCA5THuh64LDXWKpYIZP
	ZOnWerd3CCgmrgwbEirVw==
X-ME-Sender: <xms:mfrKaMNrId92JTknKW3ErfzkB_dOCyLFwKo11_8Z1HBilsUNxylz1g>
    <xme:mfrKaC8wxsHdqE5-94zbCQ8UZWXru-314Y2pxD_GIP4fd0Qz8h58Mw6SFv0STWNmf
    30O5DdvRpBuPQc1LOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnhephfeuvdehteeghedthedtveehuddvjeejgffgieejvdeg
    kefhfeelheekhedvffehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvihhkkh
    hirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehg
    rhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mfrKaIOjvjmu5mzt7TGIMZ7ZFOi45hJv1IpZjjIbNgAWA4IMXNAaoA>
    <xmx:mfrKaKfj6dbDk8WYOAaxf50vR691Qj5YNR-D8R2Q-kMWVszyhKfjVg>
    <xmx:mfrKaFsis9macpHtRDfCz5Fn7nBUfiZY3sgAczJ0mD-bacLxJP7r6w>
    <xmx:mfrKaLkfHW1Z-9Dbwlel8Qok5L8-Rgvmsql2CNQymMxdMttTXb6y3g>
    <xmx:mvrKaI8BxjH1VScX95hq5xdBAE4ELSWB76fbHg0VpQbLuLYeuji20xvn>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 571982CE0072; Wed, 17 Sep 2025 14:14:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADpVV-8_W703
Date: Wed, 17 Sep 2025 14:14:28 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>
In-Reply-To: <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
 <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors capability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

On Fri, Aug 22, 2025, at 8:54 AM, Mark Pearson wrote:
> Hi Greg,
>
> On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
>> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
>>> The UCSI spec states that the num_connectors field is 7 bits, and the
>>> 8th bit is reserved and should be set to zero.
>>> Some buggy FW has been known to set this bit, and it can lead to a
>>> system not booting.
>>> Flag that the FW is not behaving correctly, and auto-fix the value
>>> so that the system boots correctly.
>>> 
>>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
>>> be fixed, but seemed worth addressing in case it hit platforms that
>>> aren't officially Linux supported.
>>> 
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>
>> Any hints as to what commit id this fixes?
>>
>> thanks,
>>
>> greg k-h
>
> Maybe 3cf657f ('Remove all bit-fields')?
>
> The commit there states that 'We can't use bit fields with data that is 
> received or send
> to/from the device.'
> Not sure why that is, but I assumed this means we shouldn't change the 
> structure to use 7 bits for num_connectors, which was my original plan.
>
> After that, we go all the way back to the file creation (c1b0bc2) where 
> it was defined as 8 bit.
>

Just a gentle nudge to see if there are any concerns or questions with the patch.

Thanks
Mark

