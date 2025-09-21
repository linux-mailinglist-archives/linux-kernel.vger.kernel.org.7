Return-Path: <linux-kernel+bounces-826161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22EBB8DB70
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD32189DDAA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B52D12E4;
	Sun, 21 Sep 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MFQXrB4F"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092F2C0F8A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459576; cv=none; b=tmiRMUdO0albyWB2re5kCPuC7N7h0sCvU+wyKms9oTqb/7YJIrOWlri7e95RdlhibTkE6hn0h4OlD0CoTg/zUq6xgXxZUQAfB2erWwHbf1mr0OO/BgyvaJrjunUmmgxpZku2IOtQuzd88xaaA+5VhvjUqq3UEQDUpaxtgwXtRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459576; c=relaxed/simple;
	bh=Kwb2DR+18jwI5cNdwi8ifKZG7nrnjn+MgiJ49aeH368=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L2RogZ0W95z1ndCyFw/L9Gs3wlHiVTP2wvTJajh167WPY8fNJ0STiETu02LUvAaUejfJkBazoui8C9pC0S7QJo9MZLWZbfM43+AleIBXXJvEr620cbntjZzn0dPzNHcxSxaAi2lTCp7q5TxgFOuwSXfrCQiqqRlmTqpDpoyWuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MFQXrB4F; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso1964225f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758459572; x=1759064372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5idkSU+BKR3ZQwW7g3jePyMPbexa7ttPs8Jbe39d6Y=;
        b=MFQXrB4F2/UhXsFMNENEg0w/MOuZKTANXji9lF1Kpz0qw5n3GVUVUVNeNwgMJ6Dggn
         KU4XxWCEksgV9+2IrGcI7vBUqAR8CgIu3SgrPCRpxU1TxArXf6lGsm7bgqynWsAdmcuv
         YvjLSfIbskeGIzjSV4eGKR/czaOfGM+RqemoVE0d1sEWqcZhe/0HdgX6BasIiP14qawb
         5D8MPAbSaLmGfmeDiqOsjWMtxC2IrF18Zjk6zkm7gcGQu90TDqovIpw6Q+7Th7sxl9XN
         AsNEvJ7CsqapHqhHpQ3yaY78dy5qcvMhdykZLmet/U3gdXM+nuIFJaapE0kVb782517i
         4yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758459572; x=1759064372;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c5idkSU+BKR3ZQwW7g3jePyMPbexa7ttPs8Jbe39d6Y=;
        b=LgpC6+woYjcyKVbLhr6QymhPtomJazy2Y7FJd6osqoClG9eVM1dHxizo8CE256GZR+
         1oHLrEza0xUXiiiAhoBjaajxEGbl+X/7tyKId6fvBnjtKpHhKOE5V4NGa+1MTjbHi6/e
         GhagQXpfNUX3q83CT8sTShvmhx0GEjY2eXIGTox1UScLzokucAgNH1PN7BiMUkvl2nGs
         vwD0Jg/e/XLeUdGPKMjs97ISkv+1EBZEpXF/YjDZoxJccDo/Il9lpQoGyci6KdhT4DWU
         awX3Ip3H4zO6SBV0v7cPjBTkkzy7Quu8NBRXPsFOVxs5OO6d10TQaLhbTY4elFDfz+a7
         z3hg==
X-Forwarded-Encrypted: i=1; AJvYcCUyg+YLbBWOqPveYioYDk4vaDrCSsbSdaGOV3HU1XC9Mv/+Mb9F1AhTa9ELnoCWkD7z1DYYhl3gctx+5Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWF8u8J1Z6BrpDOrDqlPP+yfcq6Jx5kMnGeHZl5Z2a115TJfZt
	Go4qXswMsHDajN3civqQBDRDPiXsz2d/WQZJ0OCNmWPM7UxjViWAjCKf0WjYcA29p4Q=
X-Gm-Gg: ASbGncuzMr0FP86/P/tPnK0vcpmKqaiz7Zw5IFrbdQqdkR3eBJ1V3DigPgnapnACPKX
	/V+kaVjH4ETmhdM2RliYT86phmwn5PO4jv7KeJFLN5bPpV+fRLNvKH04cGzrCjfHzUL/ot0lH65
	OGr5reaBeHURwXeVTebbnJIBns5NJCNPZ0v5L57ah1TwzF7oHiIUePz8f8eQO69pQ37pZTzb/K+
	3+mUPw0LYaP8zfJWLDU/EjlgYoSPY1L4vVwJ3T7tORUmjk3oON4abREdCyts+AZpCFdCxHa8mdS
	QdFbF9jku99DI0m5cZMiHk0oANpyrdwkknxIXDgZkbNElzgrA06LCCHVtl9OO30jvgwp++bma8j
	5Qc/wl7wd/zVqYBnsJCPz
X-Google-Smtp-Source: AGHT+IF5u5KFKGE6iHPiMYbq57D+M8vvvTozHCB8HNpcyQ3vLH+m58k6knvjof0DtBjLGD8fC8CtWA==
X-Received: by 2002:a5d:5d88:0:b0:3fb:bb69:d91b with SMTP id ffacd0b85a97d-3fbbb69dc8amr1338524f8f.2.1758459571949;
        Sun, 21 Sep 2025 05:59:31 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:585:dcf4:2643:85cc])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbf1d35sm16734349f8f.55.2025.09.21.05.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 05:59:31 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Mark Brown <broonie@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Michael Turquette <mturquette@baylibre.com>,
  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman <khilman@baylibre.com>,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] clk: amlogic: clock controllers clean-up and
 factorisation
In-Reply-To: <CAFBinCBe3LhN+3beovFVuWPpe3pDF5P1wSt7nPjm=ykRAx4zzQ@mail.gmail.com>
	(Martin Blumenstingl's message of "Sun, 21 Sep 2025 14:21:28 +0200")
References: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
	<b88a947c-7074-4fed-8283-c278b573a7ca@sirena.org.uk>
	<CAFBinCBe3LhN+3beovFVuWPpe3pDF5P1wSt7nPjm=ykRAx4zzQ@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Sun, 21 Sep 2025 14:59:30 +0200
Message-ID: <1jldm855cd.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun 21 Sep 2025 at 14:21, Martin Blumenstingl <martin.blumenstingl@googl=
email.com> wrote:

> Hi Mark,
>
> On Sun, Sep 21, 2025 at 1:25=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
>>
>> On Wed, Jul 02, 2025 at 05:25:58PM +0200, Jerome Brunet wrote:
>> > The work on this patchset started with the submission of the Amlogic t7
>> > peripheral clock controller [1]. This controller is fairly similar to
>> > existing controllers. Once again, it redefines the peripheral clock ma=
cro,
>> > the probe function and composite clock helpers, even if it is almost t=
he
>> > same as in other controllers. This code duplication trend has been goi=
ng on
>> > for too long and now is the time to properly address the problem.
>>
>> Friday's -next breaks the boot for me on the Libretch Alta.  The system
>> doesn't show any output on the console unfortunately:
>>
>>    https://lava.sirena.org.uk/scheduler/job/1853204#L1606
>>
>> Unfortunately earlycon isn't turned on, I'll try to do so at tomorrow or
>> Tuesday.
>>
>> A bisect points to the patch 4c4e17f27013 ("clk: amlogic: naming
>> consistency alignment") which looks like it's a squash of several of the
>> patches here.  Due to issues with the bootloader it could potentially be
>> an adjacent commit but this looks suspiciously relevant.  Bisect log, my
>> infrastructure does retry the boot a lot on these boards so even if the
>> final error is a bootloader issue there will likely have been boots that
>> start the kernel:
> A few days ago Marek reported problems on an Odroid-N2 and provided a fix=
: [0]
> It's not queued up for -next yet.
>
> Please give Marek's patch a try
>
>
> [0]
> https://lore.kernel.org/linux-amlogic/175834437006.4354.11933545174004616=
373@lazor/T/#m29128b0acec2db62d45971d94a1c38fedc8493a0

Hey Mark,

Being on the A311D as well, it is likely to be the same issue.
I suspect you would not see the crash it without earlycon indeed.

The fix is in clk-next already so linux-next should get it soon.
Sorry for the inconvenience and thanks for the report.

--=20
Jerome

