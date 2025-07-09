Return-Path: <linux-kernel+bounces-724017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559FAFEDA3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D8D16C5D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF52E7181;
	Wed,  9 Jul 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="tfM/00Q/"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976992D3EC1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074604; cv=none; b=K68+ahkFn9JgqSClMCfFJ/xjlwFk/JKiSwzufFTzUQil4Io4/5HhaIC2M64rDloRPMZl/U2Tie9TrxMLVdMf1MFA8OTLOgkBiTte3hwy6/sSl1l9H/3mU+LnTm7Xos65hfpIzn6uGLV7gGYJVC/N6rv0UjZz+gcYbUFePMgy3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074604; c=relaxed/simple;
	bh=xNwWPqmfXox92HseMYI7HIS/IbNrVt1B74JGLKAC26I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFNGiTDqqJcENeipv7V6X4ukopqPqOCoNQqlCXVMvKH8oqSJIOnoN0ITRfnhQ7w0aSmYTsjbAsr89mHFY05pXt+bonzsxRsP5F3QBOtZMBtsLmiwth7WEchnZqfIUzrjtSUf6HpDHRfGsQfbfBM4pDnufDWrbst4OKBPPaK8+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=tfM/00Q/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d3dd14a7edso865878085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752074601; x=1752679401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=taKscuAxBARZZVcojDiir7HwGviwhLXve6yI29pYzq4=;
        b=tfM/00Q/tJZssHdpFGe4w/pocrFNZCY55Kg4ExwytRN+Erx21XF4V15vIqVJbAL5Xs
         P4k9lxxYlJn5lvRwIxqKdgNKF2lFs8IWW2Mg3LMo9/iLNTNGxegDpHmmQ9cKSOLW1wYd
         eLK4vpXxwSd6M2y5nFP5Ui7gBbj745vovHy4bu5pYvv+yYPD+UM/VtLUu7FAaf/OXKLy
         xMGh/amc/AKpQyALk+QHLYMOjN/agHxPI1u2cHXIgNghFogGQTxPfdLKp5yX8dFXZ2Ps
         U2bQqN27LxaebdF3j5sBl9H6jFEs6V9kyiyjjqCnZJhj6W45MWOsOwZxXggNxPxHEAhY
         gGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074601; x=1752679401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taKscuAxBARZZVcojDiir7HwGviwhLXve6yI29pYzq4=;
        b=duw5L3U4u8+BaPBJcyNtqzEsWiKOarzqtX/z4SeESnU8ebH2W7JCTNM1oU2QzwZ53W
         f6Bdkzs6QPxHu1iJcG8ryzOz58lo5PsnzMRwsJo+JC4fS1IyhYof/UcnCGYqbRWRtX1+
         4AUirVgpggLDYZ9lOdg09daGGQGfoRu8e5WpyfAyweh5EzpH3OdGXWDUezVSGwIcGoTr
         jWHaChpyRo5S7PhuA3UBcqbhTklAvGRa/wEI1utHHn5dsxkwZvWnY6bKUu8ypzkVllI9
         oH1+Vm43pXhkSzAsP5chwiaea+mvBtd6VsWU/+xMwP2RLZTygrLzVPRo4B4hQxfVYGo0
         EOgg==
X-Forwarded-Encrypted: i=1; AJvYcCVK6A7Xjiwdn0e8aA2zDvcsMbT3XrnFJGNXc3k3swieQBQHW3kXedXLF/aUjS5+0mEYDvS21fqXpWMjJVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TVGoeL9fTZsdYUxW5BCVqwCV7lgUXTfpJ1qI2HADeBOUvj5P
	QUXdDaZZcgBolF8mW9llsayx3tDaEqwI4a31AE5FnQrOveQXerkxd6/5NdwjgJ7tpg==
X-Gm-Gg: ASbGncvpnciLL7o4gDjFaRW4pa8/QlSRu88yWG/Cg9+aCtV2aLedASeekZ5KczxiOHG
	Sxja6AQdQQy9P364nBFUbqt0O4zkwP0tUUhSz4t+u2aWYVquBt9oLMyKw0PxKWmHT8jCpE24bFY
	/c0EE8fHGxRwp4EsqmDsZ4+mdM6F1w6fG4uWNpfZrlGozn4W/HlLE0/rzNO7n2whvnirgGOCyFa
	mxox1ggt0TZcqPUkBp6FnlZ6uXmKem1jC4gotiqB7S8Z1zwvWGjOB1nqB3GViao9O7aOVupiqkW
	Lsf+YxXfwp0/aOth7G0oPn+0eUTJEhdzef5bW4gYWTjD2sPVVHogufz2rvqC++ttbDq529RCXmk
	a6MCVsLRQuLcXA7c=
X-Google-Smtp-Source: AGHT+IFbarZZxnuGdEIcNxHTdtx9ncDHcHXXZLfwwDFk0c7S4XwskR5r0Tcfdvp0h6o4S0UIJPdXug==
X-Received: by 2002:a05:6214:5981:b0:6ff:16da:ae22 with SMTP id 6a1803df08f44-70494e94cd8mr5492326d6.17.1752074601088;
        Wed, 09 Jul 2025 08:23:21 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ac6dsm92634596d6.96.2025.07.09.08.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:23:20 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:23:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] HID: core: do not bypass hid_hw_raw_request
Message-ID: <dfaf82da-c389-4758-ac2c-102fc418ed41@rowland.harvard.edu>
References: <20250709-report-size-null-v1-0-194912215cbc@kernel.org>
 <20250709-report-size-null-v1-3-194912215cbc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-report-size-null-v1-3-194912215cbc@kernel.org>

On Wed, Jul 09, 2025 at 04:51:48PM +0200, Benjamin Tissoires wrote:
> hid_hw_raw_request() is actually useful to ensure the provided buffer
> and length are valid. Directly calling in the low level transport driver
> function bypassed those checks and allowed invalid paramto be used.

Don't worry too much about the sanity checks.  If they had been in 
place, we wouldn't have learned about the bugs in __hid_request()!

Alan Stern

