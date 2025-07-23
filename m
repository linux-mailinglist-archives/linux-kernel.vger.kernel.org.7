Return-Path: <linux-kernel+bounces-742347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA2EB0F061
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5B7AA63D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B128C5A5;
	Wed, 23 Jul 2025 10:48:55 +0000 (UTC)
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086528C022
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267735; cv=none; b=MCU5WPLHqmac1T45p1+DMBlU/tYX1GjY4jlFw+XZbGD5GDJFbOSIGl70BrcxG8p1v//CgXGtC6l6yi95W+K33TU6a5GfmZqbhn0goPAJxzzHydA82hb0TUADJWUcPNLnoqAZUH0xNaFLPLXx8Q+obVzpAE+diZNyvq4getBVWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267735; c=relaxed/simple;
	bh=NzpH8VNomFVF3Cl8fkxOhcssD7dMa5K9RHgP3uWe85k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uKD8MyL6wggyygfsE9mIbsqgKtK0gkzZUe5ahP1MtRzHgx3H/8D0vQW+AKY7WXtIeUe0OplNJCNb5QwjYI3Vp2M7kt7kkpwm8x4AhAPcZ+UOs6MZtm/STcGZmobYZNDn915REw67/BOtNCJOHweYBziZErxxe1RRjA5t+F/7xF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 95B7D3F108;
	Wed, 23 Jul 2025 12:48:48 +0200 (CEST)
Message-ID: <c4e878ae-e97c-4826-9962-fab15d7da632@hogyros.de>
Date: Wed, 23 Jul 2025 19:48:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: POWER9: duplicate interrupt line in /proc/interrupts, kernel problem
 or userspace problem?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have two lines starting with "LOC:" in /proc/interrupts, one with a 
comment "Local timer interrupts for timer event device", the other 
"Local timer interrupts for others".

This makes collectd unhappy, because it uses the first column as a 
unique identifier.

Is this column supposed to be unique? (i.e. is this a kernel bug, or 
should collectd expect this?)

    Simon

