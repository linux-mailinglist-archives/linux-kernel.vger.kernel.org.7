Return-Path: <linux-kernel+bounces-851531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2EBD6ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F003E804C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080462571A5;
	Mon, 13 Oct 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDOHLq/h"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0201FCF7C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396009; cv=none; b=Kbb3DAPWSsRWKq3d6HcBPmIU58I/30DeapmuizPdblvshMNEXick4UoGyySydnF2GMxGxMgciqxrqkT6jbRUAomR5xRRda+BdYETR74jVb0XsojsvlG7zMpJsF3k/zWcQO7j3GHbK2G66H6gozOTsLqokBpllDzoh5jKyfkySs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396009; c=relaxed/simple;
	bh=VxDmSLJ7Pl58cmqGN/eTKyC6uRlD8Xhn1Kk5fyLUXYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaqkS/bZ4kZiXMiGVW0uAd/2eMKgsHehwQ8ZgjE2aUmdO03lSLmr6mLsR5PndlE6ahchIs5mxqxQJWjTpoq/t23fnxgeZldbPntvtH22buAljQXuSz7BEltjb2Ptj2LvfnqY8vZ0RFVed2n+YEdwORFnAbG4ZtPx7VvS7gfUMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDOHLq/h; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee1381b835so2888726f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760396006; x=1761000806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VxDmSLJ7Pl58cmqGN/eTKyC6uRlD8Xhn1Kk5fyLUXYk=;
        b=TDOHLq/hSaw2994qUBI6NuSlboNI53oBq0aiCrHz12nLpQiuCr3Kez3TOvJSJn8LFm
         HYdX2WfaOlDKikibLegCJlcJ2UgdInGHIuwVLDODo1JAshszMZb8ZNzlg18l+zPAkHXD
         SfdNfygJQKTuMVgmW15C3xwehuCt/fYeRoFn9Q5sdAq0L85XV6lAmTHsForZ1Y5hGSl0
         qmk9ylSvJ7uKaLyNi6L29j3VrgCvW1zlRsi6YqRBH3Ds03YnNnKjETKiA6yUX+Ul+NCx
         wIGdPPIWCnlegIQqVFF/EA3cZOBH/prjRz9FPRuCnuJJc6FR1Jpe5uKmEE+ozIB4acET
         0lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760396006; x=1761000806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxDmSLJ7Pl58cmqGN/eTKyC6uRlD8Xhn1Kk5fyLUXYk=;
        b=JU/hfj5eyUM/CH8RZI/Z+Z6Ja3dIzEYt5e9jhwy+4Bj/mrwPJXZVUORzkcyz69QcYJ
         HBFLM5W2cNsaoCPwPLyQSvApWeWWf1Jru1uaNGIWdFIT8UgaRZo16OFBio+8xv76U91P
         kIG2OAS1lKjUDyMwn/wIiRJllc4ZPuclZ63GvQtCrT11eI4qQK8Tg3QB1EeHUFfvGS5h
         cOrRiegFC/ePm+vnnxnbWqucyG1ao6RopUZDhDPInylpVwHm60gw0dc8Tm9Bmwh6HFbe
         2AOumwfpTmQJpre0b/62LPz4rxHFVJiFI4rAbd4dPPntPwwNrz+0ZoHXfd8t8RyIrUcK
         4CNg==
X-Forwarded-Encrypted: i=1; AJvYcCUFn9Vs5rkzwUbC30ydbEJGdsPZyt3NlnUSXDCnubqEna16ogzJ4glisDktU6XtXo2GI0KG/XlAr6bXmvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9YVEoFHwuhXwsVihKY8cCevSx4vecE2KZFgqjp4UVheET6KE
	w7v2Woo56sNLkUDa6RvWHhkzKFWklkCBVddvqKBjEFTcrhd8utuSQLL8KG4PSIJWfbOy6nzRFKt
	jh9MKro4MAU7ZOoYZ3BumH7/pUQyHkltNprnE5wZw
X-Gm-Gg: ASbGncujXhDJ8QON1IK7dWqIRZnirC1+h0qZvJexy4PHMunPk3pO+fTU/8Jz4KniPha
	GCcZpNvxrzxaOMnSQTz2QJUkPaEdzJpZoNhqvLpF/LeWmk/avSR5wkYKOeghr5MmqIzREaIw8wi
	3jVv3lttgDZ5qQKtZF6cT7rbyfwqwCazmaIk7RfG/SvXwimLl3wjFYvZEvsg0CXwkqhFgY33IR/
	kqZs9W8tDdiFhTQjfB1f7mnciV38LBJRbR/i1Xw8g/FveXd2NzgcOoijCa3VHg=
X-Google-Smtp-Source: AGHT+IHN0t3NmIlHBzBN76m1atkXs712mA3WKLgcMNSupWFwJZ3i0jdFLSUHLWMjbly990ZrauvZiG0fi3+9cSLBVUQ=
X-Received: by 2002:a05:6000:2f82:b0:425:825d:2c64 with SMTP id
 ffacd0b85a97d-4266e7d6472mr16363020f8f.17.1760396005998; Mon, 13 Oct 2025
 15:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <92c821fb-537a-40e6-98fc-616941b57778@panix.com>
In-Reply-To: <92c821fb-537a-40e6-98fc-616941b57778@panix.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 15:53:13 -0700
X-Gm-Features: AS18NWB5frOXzr6oF_XfKeFC8F4rRq6IsJiUPIJr2IgROQ85_BdLxUbQKV6WZZ0
Message-ID: <CAMFSARf8--QW9otZDFGE4yr9i_WjYuwehJ0cV3ioD8KZFzjXaw@mail.gmail.com>
Subject: Re: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
To: Kenneth Crudup <kenny@panix.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kenneth,
You are correct that adding POWER_SUPPLY_USB_TYPE_PD_DRP in
ucsi_register_port_psy() is missing here. I would have expected that
adding it resolves the issue. I'll take a closer look, thanks for
raising this.

