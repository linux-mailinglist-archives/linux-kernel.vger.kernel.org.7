Return-Path: <linux-kernel+bounces-875093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9187C18351
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63871A28216
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDFB2ED871;
	Wed, 29 Oct 2025 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ruwh5fMt"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E91E5B70
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761709856; cv=none; b=X63uiCYwe+qGUdHMah8n1082H3ZJkqoC+7mvlO17LCenSOGMLRXATreHJYz0CVqOnN8vqriPuGHnE8+71+x2WbcPfxia/P3gQzWq778f0mayUzHFPL/JG2FR/szR2svXaW0PeTmC5WtAZ+wDo2W0llwSL4l6GcJwImEgEge8Muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761709856; c=relaxed/simple;
	bh=0urVjLPblmbyfH3k+nYsPPTQ1W0iGRpAerhpnJQVNk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpqzgGLMKSM1/VO8mORDfFhFU3O/sCL8c1IjNycr9xfoCUIzN0Qru9mGN0IpJ6Can0qawn/tVb9TpC5YxbEsmeGkLHKAhVLOKeHuIKIA5ho2xeXfZp5h3Xb0RcbidjJC+8LW2WpEenylBLBF0msGkNu7sIv6JL29oDU8nD2fJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ruwh5fMt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781010ff051so4598245b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761709854; x=1762314654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwXYnLHll3c3mFZvlPqkbYLfqdqUZDaPqK+rO8VMv3A=;
        b=Ruwh5fMt9qhl3PVrfIp30BE/tWjW5UsloTttLEZzRztJ05tEp4Rir7XPNTqZwswpHC
         B4V5ZRQRUrFaO09Vx7An12Ycg1E4LNrSATONP9ef3PHTz0L0FaRGX/ZtveVE/d+fwHPP
         D2f+Maxidhub49W+wKwasInwpqJ1vCKx/gUiSrIjW1yd+UPrY6ZFgPk65yihAUi9Ozuw
         rWpCZRkY571+V1/Sg56CQWbBt+/ChpS2jHVi6BEHBh1poiZUKWmMLTaKrZvwvXfVPrtq
         cwqbFISw66j9Z5Bd4s1NHPnlDTjMqAOq1u7jPdqIBW/FLJhZl9X6JocgOix4xv8PZoyc
         568Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761709854; x=1762314654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwXYnLHll3c3mFZvlPqkbYLfqdqUZDaPqK+rO8VMv3A=;
        b=XVuPyS5bS3WH1momZ3CmZ91aw9ZDQiN9UFGG0gnwn3fXDiktl0KLFGsreqRn8tA5Fv
         me61BTHfS94uWcYjhc7pHKakKM70eLMu3jEmZPexXSVsd09z4+5HACh3cmedErGDn0gr
         X1GWFmiKEAagbi+3NITsV8rNu9pztChMBay8wGGXS+TK0r1rqNN1NaxlutT2k++3uhyG
         qClBDmNf7+0U7RJOZpaMourLD+ANBLO2P6qfeoQc8rEe+qwW/xtIQPiQC3MbycgAPy4j
         A1njp7DrpaSfrQ2wFlUdTIW7khBUJ+V7Znr70qdP0Vd45YAZ4H/GEmrYlXPdbPWQxXBD
         1HPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcKhuCFm2LCwXpifFHdJ1k6Y3vP076Cf3iybV9fQDZLX9W4a9Nr6AoFPNUo2lIkOFltfdW/CoycnH0h3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNCnHul2lssV9uIkAhqvEfG3C1zyKgXGBqVCB3QU3zyF8Fbt5
	mpLQ79guQ8oifnpZlJlg/ZZ22Ke6wMncLUvRlvrjEeMJUNlAd/K1Rl7+
X-Gm-Gg: ASbGncu/GAg8R5DsXoo6ZuLr0aRlpibUykINwLmuyjknCwfdNUsQVB4HepKWsnQN1c1
	ueDr4agBezKuUkrlaDtHalQPwbyR5Giabmw6cHX/iHVruh1+F980rU9/h0nizEWFKuEH4OGtpvK
	9z+a8UfmZxwQZCUBcnEujN/UG+yK7ylLJke3P7y/nWbsKBsoCtncZ8VC95htQqg7dxqOMf5Zar1
	Q4maM66uqsWS4LWZLYRlCRrDzivVvEu/W3sPVtrzgYecbY1anuE1EcQVCv1fxGGbfkGea0OgnsU
	YZB3h5F35SsN3PBbCjbd2aSyTRn1d6eellHkzBL2rFs9YvCkvbM/Q46IzdMdoO29G36upWRaqui
	hajGg1P/vfWzzFhonwmZMTCsnmgGHdzs3QFc6piltDsJ4658oNnadgrGbLo8eBSSL9BgJ8bJznq
	5ap+qJA48gGYYjRHXyCEH1NDnLsarbXXlR3QyWfZCIa7K7g4g=
X-Google-Smtp-Source: AGHT+IFZ2qDHNmI7HmZ3mZKfX113/QMKS8CLQWPjt/c9Tp5sY2iiMASjmfmEkRs+NEYMQl7jQAycFQ==
X-Received: by 2002:a05:6a20:3d10:b0:341:5e2:d354 with SMTP id adf61e73a8af0-3465323c289mr1608663637.37.1761709853972;
        Tue, 28 Oct 2025 20:50:53 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:5568:45f7:ec26:fe8? ([2601:1c0:5780:9200:5568:45f7:ec26:fe8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdd50sm12423966a12.0.2025.10.28.20.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 20:50:53 -0700 (PDT)
Message-ID: <e4882d15-1ba1-4521-ab52-365eeb7f77b6@gmail.com>
Date: Tue, 28 Oct 2025 20:50:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/vblank: Increase timeout in drm_wait_one_vblank()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, maxime.ripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
References: <20251028034337.6341-1-chintanlike@gmail.com>
 <2dae83e3-6fee-4e66-964e-c7baf46eecd8@suse.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <2dae83e3-6fee-4e66-964e-c7baf46eecd8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/25 10:14, Thomas Zimmermann wrote:
> 
> 
> Am 28.10.25 um 04:43 schrieb Chintan Patel:
>> Currently, wait_event_timeout() in drm_wait_one_vblank() uses a 100ms
>> timeout. Under heavy scheduling pressure or rare delayed vblank
>> handling, this can trigger WARNs unnecessarily.
>>
>> Increase the timeout to 1000ms to reduce spurious WARNs, while still
>> catching genuine issues.
> 
> Thanks a lot.
> 

Appreciate your guidance !

