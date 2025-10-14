Return-Path: <linux-kernel+bounces-852430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D2EBD8F82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A3124EAE11
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC2302759;
	Tue, 14 Oct 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-teism.eu header.i=@bit-teism.eu header.b="YgRUIhal"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1A3090D0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440692; cv=none; b=WdzZv8CQZqvtOtZT5WKN4EwxpnPkmAhAPYrrGch2EP8Vn/pqn3iyLBHx7dhwX1dU3Zh2+jTOZ1/aSgMwRQsmxRpr1Bj6J9x/dmG/FiSdVqhAoadxBpD2vTtfmVCCh+jstQpesA2c9oSV415tiYOWA1wOITqhLfcIaCFFv/vLmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440692; c=relaxed/simple;
	bh=Os9XzOaNHUFrlOo+HyQ0RyjGmoRzjK2tnqLhyCZaTvM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nCLV7WYPZB6E05xTC12FcCy8w9xJuLrFIPG6mV4tMYBqb8HFsJM5N8elhQC7IEdf2xMZFSPNgKc18Gh9CpI8n+OGv/ZODtf46qiiws7f2t2JrblMZWVIM8Kg8DeZZ0DLRvrp8t/foJcsFDJzf3QbtEwra9OJfQyzhlCezWru2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-teism.eu; spf=pass smtp.mailfrom=bit-teism.eu; dkim=pass (2048-bit key) header.d=bit-teism.eu header.i=@bit-teism.eu header.b=YgRUIhal; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-teism.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-teism.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-teism.eu; s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PTn/YbEkANztox+RBOWdGm9P0uuiVqL2+pLsLQ23ZDk=; b=YgRUIhalzf0LzhANsdqC9Qyqxa
	aAGnctsHZ44QHGVd1yHOmrEUsV5Sp32Jkf81lzkwLQo3abZ9XqwnqDBtO5LMbNg9IQi6ImzwodMRE
	PPi37sI8kjprSG5XzaW+WilfifikkMM5uahSeyqiUGvea61nK1kE2FTbuZVUL6Qr0dQ2CMkpS+0xo
	poUU1jOCuqeGHGknQTaHkYb33Vz3luTQNoO0btG/X+Ttcxq/2PbNjmopFflM9gdgGKoOjd1QPlBSd
	/BLRfJUzvVYAm8gdMwJYqFCZHb25Oh1CiB9DwqwJHeVlcSamL/pbllz+avxtBFTgZhkipmyvJmjyF
	zlANP96Q==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1v8cu5-002FhW-4P
	for linux-kernel@vger.kernel.org;
	Tue, 14 Oct 2025 13:09:17 +0200
Message-ID: <0f74210b-c614-4b24-8065-dcd5f69d8e16@bit-teism.eu>
Date: Tue, 14 Oct 2025 13:09:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-teism.eu>
Subject: Bit Tao (was low jitter, fair pay politics, unification in Bitstreams
 System)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I have reached perfection in translation of Islam. I have updated 
the general project name to Bit Tao.

It really also reflects the want of Bit Kernel potential branchoff, to 
have Lightweight Kernel Threads only (instead of legacy kernel threads). 
This is fair pay compliant. (And other stuff I said, should all be 
reflected in Bit Tao now).

Fair Pay compliance also includes potential Isa CPU and language, as 
indicated by Bit Tao. This way typical involved are with right concepts 
for this. Test what Bit Tao indicates for you, if you wonder.

I also suggest Bit Wavelet (fair pay compliant constant-q filter, 
compression and more.) And Soundhacker, versions have been part of the 
culture for a while. And SinAI Game Genie, for easy game creation with 
Open Source background. (Some of it is already looking better than the 
manual stuff!)

With full fluent translation of Islam, as Teistic background: 
https://bit-teism.eu/

Light Be With You.
Ywe Cærlyn
Budi,
Bitstreams System.



