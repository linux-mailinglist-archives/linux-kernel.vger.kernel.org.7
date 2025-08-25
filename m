Return-Path: <linux-kernel+bounces-784096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4DBB3369E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7BF1888A18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A4284686;
	Mon, 25 Aug 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj4Napvt"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE182777E5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104198; cv=none; b=aRfWU4VBg+JjO1aEpFR22x6odOhY0sxZP7ah/WobuXbj0PqSa1VJvTan/Mm+K+KE1FRyqdfWOTZB0KN8THyawcI38cLoz9P1qg4eliGHJ7RfnwdsvvFPoeJCryOsxD7Rlucadq6D1gkKWCcMz+yUWrH6CIRW6+h1YRwqdmsZ9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104198; c=relaxed/simple;
	bh=Z8yXtF5+1+woiyPxJQahYOwvCXk7uL1ska1V/L4DtEw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=refyhq7GPFkK6MibNch8lsK9u6mzxfF8BZyRhVy7yUDeWauLKkXi0y41d3+jrkLfZjhnoDfE1LnkrW19qEJMc0DzPbHTT9HccJ6ZOt0zYWNATspm8wrcMg9NXlTKYUXZ+KgEJwui84pX+5jrz5d39v3avXamfxW/KJAhFJw/IL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj4Napvt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-325195d1b1bso1882282a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104196; x=1756708996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8yXtF5+1+woiyPxJQahYOwvCXk7uL1ska1V/L4DtEw=;
        b=Kj4NapvtSiTDQEGdVJPjn4ufdVwoFzvlTG5pTOdMW/BGcFNuBrsxvRxbYvz9PEyUxd
         ZUj0AM4z/v7DT7jjLVVjOrRNf8LtDs/MartFufAjxsvk4MmsBtCEpX2PjTo7t4jLMo4O
         UizIg8f+7Cmj7cmb3b0xMKCmTJrWpRxsUF3c9cvj3glLReN11dfToSn5euqoNOtNZMUC
         /6BE4V8LYDa/M/Wb8vOI0klA5Ez6O6kyAlVSGLw4hRsZVKPAFwfmUq1YfZzcnMVViqqg
         Wv8VFoVVMkazKylWvDUVCRmczYW7zAHiKtMtdY9Yxvnwu+9HVQSwlVF75i6xtRxCRDQA
         kXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104196; x=1756708996;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8yXtF5+1+woiyPxJQahYOwvCXk7uL1ska1V/L4DtEw=;
        b=SnsL0lpvnF4fs2XBtTlty0L2nzcGXIfSAY61d8KnHa+KsXaUg/xVI83p8autVqcM+y
         iO0hKTmjfsiw0ak8fjDd2OvvJt4hdMAxuwKMj1G0PxJkkOO+sPxKP09TABq41qsMUrDw
         ayaOeRQmwEbN6SB/Hc/i5HEi2XEw0nBC474KeMtTMJTjQpYVYUwkVOlPG6DDu+WPUy8P
         /WsGN7bdEK+ZFA1pMT5gibnLVUJ4p70v+S9vAIdK0SELMAocNtJedzqwQIdDCCv+8mN1
         riDuPU/XnmO5T2TW67yr3pKa9UHtnX1yBn2082MDuBIzL0cuo4zGDyuQ8g9wycRCcWWb
         16LA==
X-Gm-Message-State: AOJu0Yz3gP8cx604XOTRs2psp0MxyGw3+owo8K4pCduGZjkdP8ONLaej
	I+/Uzm+omH8FzfeCFsbd14hndsVpkrgg4ubX5D6cJbsatjX+SMPl35HxlFfpINc/
X-Gm-Gg: ASbGncvlvfyalcY0YbJ1yDl82+mUK1rPIp2aOBbhdDlk5Cbxcyng4NXJtOLMcRLA+Qz
	FruyFtB3sZzpl1UAXOD3FqGpovsmRWzdyAqeSgKqWjIpad0M7ppWpD3gNpAR951oXFph2sFhJsz
	X0JG47ijHqsNk07qVdHpWN2sWGfJpvYsWIj2d8ADFHgqsWaxWCu69LBt8TS7I5OBN/gLAmKg/Qn
	64M8uGljpL4J1W9MPAvBWRZVcMxvsPqf3IsRY1FGdCssn7kZJ7nWFjp21xrETde1m5QfePz5Zmj
	yvZ92zssX/odod7rXagoX2/0xx151HufwlEhnJV+mCc6QsG2D2OkR2E81UWPKO110Rc8OlAZMSp
	AScm6FFcXCKVAg4y/rZw=
X-Google-Smtp-Source: AGHT+IF3fE28nII7w+inunBK8eIns6W1NCRk0D5I1bmIbtJN4WTpBU2PBrmtNCzbbJqG3Vay0/M8mw==
X-Received: by 2002:a17:90b:3ec5:b0:321:265a:e0b6 with SMTP id 98e67ed59e1d1-325177494ddmr13453364a91.20.1756104196390;
        Sun, 24 Aug 2025 23:43:16 -0700 (PDT)
Received: from [10.2.0.2] ([149.40.62.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b17dfsm6395801b3a.68.2025.08.24.23.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 23:43:16 -0700 (PDT)
Message-ID: <0d48d0f8-2a82-42d2-a22d-5d39cc0fe4f1@gmail.com>
Date: Mon, 25 Aug 2025 08:43:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
References: <CAHk-=wgKmy+gOftf32wT86F+mSvdq2=XZe8Tcb5m0NaQTZt-dg@mail.gmail.com>
Subject: Re: Linux 3.17-rc3
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Herman?= <rene.herman@gmail.com>
In-Reply-To: <CAHk-=wgKmy+gOftf32wT86F+mSvdq2=XZe8Tcb5m0NaQTZt-dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> As suspected, rc3 ends up being a bit larger than usual, to balance
> out the tiny rc2. Yes, 3.17 seems to be generally in pretty good
> shape (...)

One would hope so, it being one mere day under 11 years since -rc2...

https://lore.kernel.org/lkml/CA+55aFz+3JzdB+sZgOFfzd9zczL=borNgLwZykx=_tOMD6n4qw@mail.gmail.com/




