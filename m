Return-Path: <linux-kernel+bounces-858057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E248FBE8BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D26A5041F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577B5331A6D;
	Fri, 17 Oct 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="K1cxlvQf"
Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF27341ADC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706310; cv=none; b=KUR5/iu2yK80E8HeQk6TlooBzIxijuuwVl9Q/a8kUv2i+qSc/kTUMoDGob9tVoDMeLASnXCYz0ui6b58yZYHajVEvhgY9R+hmblOqLFEa9TIVGyU9NrNVx3bvXI85Rkt7NhZbsdpTudFpCYsfE2NoDyd6bicidWM6qXiP+xCuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706310; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4D9cZrSdhMHTrorRSTQxOPRjFmVPHeEju8cdm1LUESHtJMTOxaFSSNvkQ/pIOkW6/ivs5MwZIdTG5Lj4yjxCIVZSYEZHS6UDtaQ23pRL7QMqCvW76F8pjC72XW4pL8efZBpc6srQyKLSVaYMyzR7+T4l8qu/b8MsRZr4x950RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=K1cxlvQf reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id 28B1E5338026
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:45:32 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705133; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=K1cxlvQfjKLyJLupgcVPYnF4bxg+7y5utj5UmAJSFmCZ6n/IRSIcbIAB//tdmqYtzpqbnm
	we6QyRxsgaRJp14V+k8gu4XrirUKrq2TlBNA3Yn2P53UAanhBxGdoHOHw4Jt5tRS8GyIbr
	B2buRsAeppGOy+JhzOkqxGcJmt1eLrZa3U7lQacHSG1GZqcuzHLS5+GSq9MlWZgbdNS70K
	WKQejzEf2HrzVxKzezTzn/tqiAdmoIY6AREoN46i5PzBhPWPa+qoksRNHU+QQD7gnkFzMu
	NXFVINd/JpwpfUiMSdvzHUqcKZ242UVDwSqh7R037RtM+HQGMDnGuX2Fhdn45Q==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-kernel@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:32 -0700
Message-ID: <20251017054532.9270B032319FDFC4@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.

