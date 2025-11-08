Return-Path: <linux-kernel+bounces-891349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB9C427E6
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F603B87EE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685B29A33E;
	Sat,  8 Nov 2025 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b="Ch/3sgGG"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE525394A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762581211; cv=none; b=GgZma4jTGFViBlrwv3W3peWYATNr73Q6uJvQ9YubWsrODiW23mGZKd5c3xXZm2fcqN+dD85S1yHImQc8J3t3ckuv8WI55cyzi0K/3stVr57Y6LaXhoJKG5plNp+bIYR/YoFv9jzh1yWb1MFdnlqsREOKWfNAXemt30uitTQ4its=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762581211; c=relaxed/simple;
	bh=aDflVe/FNizSBYwUXFj7nH2PRgug7tLKr2FWCaJzzLI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j7G1LafkFDfBjqVQwMPNZxxtYxc/QXEj/AuO/t00D6+o9YIJq1cBLhIacvwjCXUUoGPswJaZ3UoVwEB+uGs4SoVd/+tFAqR70wqJY1mmeXV97DdoF0aWf1DNFpFRRdxz6Z7sQR50RpWgg1iAOI32XWsREjjsrCo6iF5cpfgcDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu; spf=pass smtp.mailfrom=bit-tao.eu; dkim=pass (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b=Ch/3sgGG; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-tao.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-tao.eu;
	s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FXNWsT0c3Tg4AZEIxVfhVzeLwktCjnlzcMmRF6/xNLw=; b=Ch/3sgGG/1FyQHOI1PtTacXuAq
	wDgQxUXVaMzVlvbxbpviS1x/j5X5r83n7UWhI7zbCOAtyJtAhD7NN6+HTjvOHkqN+d6MZAVJGI0rX
	13GteKvhMshjS/p6J5ukk1GedNt7GqbzNgmGzMnERhenZ/s/jwFS1lHxU+glUkK3B6tuGWQv3n6Mm
	aOdmvyKPR0Tdr2jPrM4tTV783KJoDhU2Hi/QyknU7OU4uV9LLrA1qx890le5svPP6O3Yo8ufRILM7
	7OolvhVi1eJg/pVDtcy4h8cB1icJAXT6dhUyepXYyOFQbVRgxj+xpjvc7Lh/0YzkRy3R6r9YEyNAy
	PXGzgnXA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vHbt4-003HAO-8H
	for linux-kernel@vger.kernel.org;
	Sat, 08 Nov 2025 06:53:22 +0100
Message-ID: <0c6337fc-21f2-431f-a55e-34cf5c010468@bit-tao.eu>
Date: Sat, 8 Nov 2025 06:53:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <bishop@bit-tao.eu>
Subject: Autist (Ja) (Was Fair Pay Philosophy, Unification in Bitstreams
 System, Low JItter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Rust seems to be a rewrite of C for Ja. C in the first place, really was 
Isa, as the Unix-engineers who named it, was promoting Isa with this.

And it seems good. Isa is a version without the cross.
Isa slots may be about this too. It really is the best.

Are you aware that if you rewrite Nerd (Torvalds people) for Ja, it will 
be Autist, said a mental illness?

With regards to C/Rust/Isa It does look similar doesn't it.

If you do not want to be treated as mentally ill you should not do this.

Linus - "Everyone is crazy in here".

He excempts monotheists here, Bit Bros, as is the monotheistic 
perspective of the time.

Light,
Ywe Cærlyn
Bishop,
Bit Bros.
https://bit-tao.eu/

