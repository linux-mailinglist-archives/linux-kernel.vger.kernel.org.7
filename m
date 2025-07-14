Return-Path: <linux-kernel+bounces-729686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B6B03A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCE01894CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFF23C8C7;
	Mon, 14 Jul 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="Jmrg4fTS"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9C23A989
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484179; cv=none; b=ET7lUs2TS3uLuIWwE8b/fWazfYK7Fi+SqzfmZsW+83Rp6arRr56Hu4n+9L4PXN5S9DGPO9s9VBp7VOPWGXsNo3xmurnT0nVXAZp/WeBEoku2DqPDAj1S7LmWOKd3Ct/qJm5ygwaWj9dcmgiGx/SR6j/ctPUyXYjIz6N/VNWf5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484179; c=relaxed/simple;
	bh=rIsTjh4GLVLD+KMCZJr0+NzS5w/OyX/hLoA+6UwSt8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X335EKjCjEiD/Yav/O3SlYohXsRhChNmZOWLWBANb6ta8thNddvMaUecZz1/SHZ5Z6/3UP6SgDoFUnbFDxiliuf/NxizdhU+4UBTtqVBgsNFpInFLz2+PmBqf9EBqEUSG9ZfruNG1dwF7JXPLSGRBXf9EzPr3yLfln/r3iBSokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=Jmrg4fTS; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e4043c5b7so34431697b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1752484177; x=1753088977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rIsTjh4GLVLD+KMCZJr0+NzS5w/OyX/hLoA+6UwSt8A=;
        b=Jmrg4fTSkNoGP7uGFdDY0zF4L2hsIBIU1qAp3ARWsdlmTywlH+e2RhxO1U1KJZSAJ1
         7omR4Dz5UJvWvUYRjpfUd2wNa8kTxWpe7jmHvToLToTrTuR9d56TDBczo56G+acdpou1
         SM/0CQF56hRQ0KEc+eR5Htli5pMJsON3bwyfjE4FuGCEYQYDiD9vvrJVoeD+NQ/Zg2yV
         u/W0mvTnjUKI0iekiQxsnoEOlxhnEo58DKEA9xbikm+1GrQnzE1wVlsp+lhXyO/FjMfe
         GmUoZQS+tGrvXKa1XXTZ0PBf8ws7274ea83WgPgsOfqLmVTx/jYnWhYbxDC9xgK6rodr
         uSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752484177; x=1753088977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIsTjh4GLVLD+KMCZJr0+NzS5w/OyX/hLoA+6UwSt8A=;
        b=lOlsnN8MztnFouMC40ePslQkSGp1Ro9uF6U4jeKcAAbZOh+HwAjAWH/9MhGeqxSybn
         mMtccNQZHW5xzVlCoL8X0/BuQ85ufrxqrP3gx0Fc7meZj/EDGNrjk5EuIEF5ac4NM0bK
         KrQ2scIIutsO6Ca3klejWTiVBgl3GBYeeQmwRHo8Ik3TUyIUn5wmAoQW2O412mf7rUXW
         LSVY5+wSEQ30u5ShmMflsc5USa+9e+Y++F9spQYRpR9PYCSQj461IviMvmr5xqctllrp
         qHOS3dl6zyxbtfLW3b8XS13k0LIP8VLNjYz4TbMnjMGrZObUFbawWWXYbVDJ9moCBW78
         G4dg==
X-Forwarded-Encrypted: i=1; AJvYcCX2MPKhnG/f89+b2m7nRw9OEzf4OgzzyWn+LA2JMq+6Kbt1D3g9cI3o6DbV+NbIH19HRSPJaCOtrjIkYwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1AZhvGCiYThZ30uq4hgaYEDieP4BZvPKHlUo47j1x1bwOmsR7
	zplP3ifmog6v8vJAc0FMWtqMfv85SF8DDG/Zp0180vfBLeNAFbizYyYcrwp1mpJOCbWsczfk4o6
	kN7DdjhWDB94tJ7aTmN0XcB4CbpNwstUfFpA5hEs0oUsELg6525lE
X-Gm-Gg: ASbGncuyJY2kKsWNWw5XrqeV2hMlVjIx27HiKdEqZjDZg+iJM5PXiPlvRUO7zU37O2Z
	weIhSqBOQcD1UFwoRmqgvGRywj2fheysXg4t9681XEQhTBZxsSHmbcmxxYOGACnEdOVVVduWcaa
	HqVWUNVMFdvphC4dW27RP4rU49C8qESGZWIbCHicoEvYYEeJefR/YbGjefCveuM+FkFdMcAPY7I
	v4rPCD950TyE910bbmvHuHXe+fEB7iKOQbLhvSe3g==
X-Google-Smtp-Source: AGHT+IG6p+03ZW+kAVBQfuO1ja5ZeFH250eIb7vurLa/yxNs3CRNsc1yO9cE5aHgOeU75DtvArG8fmDVzC3kmVUq+Dw=
X-Received: by 2002:a05:690c:6d0d:b0:70d:f47a:7e40 with SMTP id
 00721157ae682-717d790e42emr197721017b3.16.1752484176641; Mon, 14 Jul 2025
 02:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-leds-is31fl3236a-v3-0-d68979b042dd@thegoodpenguin.co.uk>
 <20250708-leds-is31fl3236a-v3-1-d68979b042dd@thegoodpenguin.co.uk> <20250709-primitive-offbeat-toad-08930d@krzk-bin>
In-Reply-To: <20250709-primitive-offbeat-toad-08930d@krzk-bin>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 14 Jul 2025 10:09:25 +0100
X-Gm-Features: Ac12FXyAHIvvIgJoN1gPJVPX6vDJtb2BR6Gk-ucRF8u8hpHHCZ5URAzHwizSyy8
Message-ID: <CAA6zWZKVnrPoutWpKQ+qzg5zNE-dhLxWBiuAoV5vf2qHfzv-LA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] leds/leds-is31fl32xx: add support for is31fl3236a
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Bindings go before the users (see submitting patches in DT).

I think I was confused with point 7 stating that dt-binding should come
last within a series and point 6 stating it is only regarding DTS files,
missed point 5 altogether... Thanks !

