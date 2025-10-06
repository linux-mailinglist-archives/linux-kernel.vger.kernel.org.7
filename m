Return-Path: <linux-kernel+bounces-842588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F43BBD153
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 07:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 105564E57C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 05:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940024503B;
	Mon,  6 Oct 2025 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="N1qcJEMG"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024971FECBA
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759728490; cv=none; b=FTLUnK/g4ghoYX4pZ8tESNm8QIS8QLPVG437RI3bAjy8nuPrLYe60wXO9gSc1lur2HHp5nQxPb5Juxr5Vw8PRe9vUBPDOtOwlg9GdhLfWpiAgGk67dQsU9SMF8NKoakymM8DmDXASi6GWPJUqmT1AH/pZDdFEtbsXc5QAO6ISIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759728490; c=relaxed/simple;
	bh=PoHIi3dOP1TILPAciaJ79sDdTdT5zvfRtEnmvsLuLU8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uQAqWNRNTl87YNfa0U20SYkahnXwqvf4JKGaWw3PiajrOa7p2HEjnLPmlCghAj3lDtvBygfzF4KDL8UxC0X1kST+pwhZ7FQHKf2WXKmN84Z5HSiEdsqJFZuVbcjS/mRlmv+3r/o6EqaMYmT8kk4aqDSCdW7C/StNKU2l3JcnvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=N1qcJEMG; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from mail.ispras.ru (unknown [83.149.199.84])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2BCC1406C3E5;
	Mon,  6 Oct 2025 05:27:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2BCC1406C3E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759728476;
	bh=YmM8TjayGWttRE8u6uRchrjtFyC7WTCG7hUYY1LzXbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N1qcJEMG1aw7sTgko8Kh4SHg7iFOjiucmgWTuDaNoq/i3+9pxr1JRRaL8Xl9y5d+E
	 pETha5vRJzklJMtA1PfTAgCbDgMPulRx9iC3wCAHWVKImRTt8VJWKCgKDSenBVTW+J
	 0ZGgbJAaXNcxSeDwoWe03v2MGCoowOOF4pZdUeiY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Oct 2025 08:27:56 +0300
From: matvey.kovalev@ispras.ru
To: Doug Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson
 <danielt@kernel.org>, kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] kdb: delete unexecuted if-block in kdb_get_kbd_char()
In-Reply-To: <CAD=FV=V4hRA8WnvxYNgXsULrzOTCdXZ9JMHgZ=XxqpVZz5DNOQ@mail.gmail.com>
References: <20251003151220.1580-1-matvey.kovalev@ispras.ru>
 <CAD=FV=V4hRA8WnvxYNgXsULrzOTCdXZ9JMHgZ=XxqpVZz5DNOQ@mail.gmail.com>
Message-ID: <d55cee5937d5b93cf5ddcd6cb3ec278a@ispras.ru>
X-Sender: matvey.kovalev@ispras.ru
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Doug Anderson писал(а) 2025-10-03 19:39:
> The same patch has already been sent and was landed:
> 
> https://lore.kernel.org/all/20250507104337.201695-1-colin.i.king@gmail.com/
Тhanks for information!

--
Matvey Kovalev

