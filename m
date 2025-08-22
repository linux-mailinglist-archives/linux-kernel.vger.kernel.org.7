Return-Path: <linux-kernel+bounces-781911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67152B318A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19786624B20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A52FE58B;
	Fri, 22 Aug 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="O9i05IB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJf9FCrO"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4892FD1BB;
	Fri, 22 Aug 2025 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867286; cv=none; b=qbI0r/cMbLqPeQsq4TqMv5jsP2356oBgSuE1C0lhS5NiVwBK8OMy1N6BjRbTyOjg8cG5wJ6zHeU4z7Ks19vjLYxhuqEN5YQboeN/5VGBS0jE2k0jrJI8jvlu7x+cFrBhCQT1Or/Spu//dMloys4/PYpw7VJn20I3EtNVUdljy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867286; c=relaxed/simple;
	bh=9WM5jNaY2Wf4YG1NJEB50AfU0AlRHyDxQ+QQLN1yREI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O+tBeuzD13nskyzvn+eHvAwfe2VzPQTnEiHnwxAeGUefnLD0vH+0cT9beLi0jUwEtW+gDyTP6GKJhKSIqaxHRrb2XD/w/K8G4dw387xYdXWV4vfgSO7flyKGFV4Sc4U1yArJk/nPEOk9B/XStm4pmW/w5hcFiOvJbgFAfGiDn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=O9i05IB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJf9FCrO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E5251D00234;
	Fri, 22 Aug 2025 08:54:43 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Fri, 22 Aug 2025 08:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1755867282;
	 x=1755953682; bh=aRZ2w4aRXo6qUfdO68AWObxskrE0DCs20pt2DafQLDY=; b=
	O9i05IB8zSotgJBhPcH917nbpHH/qgqfnnFgsj4vfqka64s9qF4kPKS/O6VC0ic6
	AAe8nf4dUWW27Kr3n8WQlNPVBvEYxNHOtY3RCaVxX28xivHTuWlMl6orHvowzh6n
	G2CXDCjtp50AojrgnWYvQOINiw8LfWeWlUWP4OxSEs5Xo6u+6PFtXi63/tRXPPR6
	laCFNlrTbwwOxKXFI5YGdH5zQwGuCMlQIS+NuEylXhUcsb2sIZP7XyvCCfcYEChh
	Hhf03wja9RAShRYoojScQG6Ltgl0UeoEJfHGip7aHX2wbBxpDYwuJF4RG1mmQE2Q
	EE/g/Xv66RnZ6VWazcUFgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755867282; x=
	1755953682; bh=aRZ2w4aRXo6qUfdO68AWObxskrE0DCs20pt2DafQLDY=; b=Q
	Jf9FCrO4swUngwR9t6qnHdFLxYD9lJFCVeDsnmwr742WBgL0im5dWqXN6q/ETZ+r
	wL16Uo4/slFz6TFJB8U6br4Ep5OVchTB5AwtR9Jjk77FaEmzbi6rMK3kwbpiHW0N
	1Xhe/+PCFsv25DNN1+ToDWxINJP75qqAcz3ICMGbqSItW6yTt2FWyfZVz4Kv4DE6
	PL0bblRMbtrHHIeYO58mroytKXUw6FN8+Z4trhqvZXaiYp9gOI/Ee417BunzNE7Q
	OQx5A4O0JTCkQLdbg0wqEYnlZeUaNR1iY6Gx6ZoH8jnvioCoR9aXQ/q2rYwU0cCt
	72gLWFn8zKMR7MZ8pP7SA==
X-ME-Sender: <xms:kmioaP9U_Se6dGPj_PDiMrw-8NA6u4uQNknJv8YXUJOue_N3gtzphg>
    <xme:kmioaLtmRGYTzVwkqVZm96sK0Odoj3ClLMOCCjQ2fJd-8gEMlqZUAL2kwfBODM1yQ
    DKqP7JD7GGcyj1Ku0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhvghikh
    hkihdrkhhrohhgvghruhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
    ghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kmioaL_aU2PGTjjy-D1D4lKNo8mtFcZ1nvqwKg5mvTYTLrGW9Q0_Iw>
    <xmx:kmioaDNQYo5OiBu3lKEa22pxYQ2N3rWNrp_f6IpNTAwbjPqeXJpj-Q>
    <xmx:kmioaPchj6JjjIYTl54JF72vc07_LFJhb7QNkhX0qLZl-QMsheQpWw>
    <xmx:kmioaCUdP4ZzuX0-vhC1NZnY5-36TCMDhYNrT_Sjj81erVPnq2wAoA>
    <xmx:kmioaJvfIWkvGDTph2iSPqb6xKTpUMSNtN6EGAM93zOJ6Uam9RKCOkEu>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 501182CE0071; Fri, 22 Aug 2025 08:54:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADpVV-8_W703
Date: Fri, 22 Aug 2025 08:54:22 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
In-Reply-To: <2025082213-antacid-correct-53b1@gregkh>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors capability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Greg,

On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
>> The UCSI spec states that the num_connectors field is 7 bits, and the
>> 8th bit is reserved and should be set to zero.
>> Some buggy FW has been known to set this bit, and it can lead to a
>> system not booting.
>> Flag that the FW is not behaving correctly, and auto-fix the value
>> so that the system boots correctly.
>> 
>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
>> be fixed, but seemed worth addressing in case it hit platforms that
>> aren't officially Linux supported.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Any hints as to what commit id this fixes?
>
> thanks,
>
> greg k-h

Maybe 3cf657f ('Remove all bit-fields')?

The commit there states that 'We can't use bit fields with data that is received or send
to/from the device.'
Not sure why that is, but I assumed this means we shouldn't change the structure to use 7 bits for num_connectors, which was my original plan.

After that, we go all the way back to the file creation (c1b0bc2) where it was defined as 8 bit.

Mark

