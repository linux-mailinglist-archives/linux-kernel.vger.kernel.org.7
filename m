Return-Path: <linux-kernel+bounces-896086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269DBC4F9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571A03BABFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C5327200;
	Tue, 11 Nov 2025 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQu0sUR7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10B3271E2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889235; cv=none; b=U2ViNIfk/rwNlTh3kMVP4VmhueaX+x/UQJZFZFlubF/ybqV+e8BkBEW//5/1f43GAmzX8G5LWP+n3hoGxdtkuRF8sHoGw/1BMcq5Mx3VkD8D57sJzmHNLBNI4xOmQnOOJwJ3IU+63j4mIBQht+Nnx99DejMAWs5dPklBxtiJ0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889235; c=relaxed/simple;
	bh=T4q4eI/PjUjqDPpGU0Tf2NYnENnLstWCYa50yyn4bPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2v1SdbeCRPnIAPqODcCtg3SqGsedLfQ5ykggviesk5r1K+D8fbgAK4H0K3Q+HcitPiHxLpgHpCnSl1Vg6P+IENv8V7y9Jy8JlgqMcMvcxZ1rp09wUiC1zLnVMyR3sZzm56uuVCDRRRBo3cYrwl84G6zyrlqQGIj1TZZrsemgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQu0sUR7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-594516d941cso60401e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762889231; x=1763494031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4q4eI/PjUjqDPpGU0Tf2NYnENnLstWCYa50yyn4bPo=;
        b=nQu0sUR7DB7tDzowR5qZobA4FUDiRlSpO6wWrJ6ejebQBijIGVgMizvWluGbRYGHrI
         MmpeIczgC/b9cTkdMIGSud/jVbR5GCP8rm/tsVg5eGBvOPLYD5kCr4F17bkv4PsHxc4E
         LIAotl/MOOd9P5dPuSxOpUGTIPl49BCyvxtwP4WnvB3wHKbxJrK2ObYjyNfkKn7pSGW7
         7VzU781J9WU/MYo6jEzuR+W6p88/KcfcXEO/y09pPmbHuh7Yg53jk05HcVW6YZdNocE6
         a2VKZkaCz/xB8LEI15xi9Kqmy1haib4TfKy4aYVXuhbN2VEWOuJI2mAEE8wVACSaSkWB
         RCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889231; x=1763494031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T4q4eI/PjUjqDPpGU0Tf2NYnENnLstWCYa50yyn4bPo=;
        b=UkdrWz/ahZ1Pvp2nQ8BKxiWpbCi8lCeFUixcJNQ1XxA2xSOjyNAXePHWdOuW6SRlpi
         Oyiq5sibljNc5LKeYYgyzwyug3uhmMi10u2rIGepkaUMUHFqhhslD0tmXs+E2/laia5Q
         bgTLUcBK6lfRvEwwJNOXjBB0ufe/lw8LLo56y9l5zRgcD0rmDLfibIQgmM7wnSEUFKLS
         kqh/oTk2RHxoBXSlre+ufKYWlOoAJHDb765c7CHtZWs5jo0sE1SgUt01MxSrwQB3O+gc
         Zpi8nPGvWAV0sR1S2w7IYag6w9k2ZJCIqjJWpvbXxluhlY8LK8gL7LJ0LHIn0AMYXNqb
         HLIg==
X-Forwarded-Encrypted: i=1; AJvYcCWsXHrI82I/7yD2oLWrJGxDotP/nCgDthPnYIscAdem7t1zKNk4CjVTFFIl9sjs8X4Y0igo+2JlWJiPu4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpao/LPc3x8W3xYaKBNEv+zgeYTb+luL1NbfXO0yHw/un1HS4x
	/FOQQMwb9AjUQeJA0/STmiI/F/rZ/piWLcHrsaH2PBG/eCQHjbGdjVJa3vZjx3uXW9luwXhu78U
	JJP6R4SKhGcjV5Ve6xCpzkCgmPzje24Sy0yMkrJUQ
X-Gm-Gg: ASbGncsIYyPsf/3Opg8wFgH/VWhOQyQ21jvgYhTAI/OaoFFcMIZY80UkeokO5rtZTpM
	fIvyqAvTbCIA8pa10HNm4PlpyYldUybVasb2PsLCtdEo3KCVi7vWWai1/YUApUqVKPhkUH1EQXs
	KCEN3232lS9SHHoZr7HfNR7vDKw34egwoSbKUkQw9CCcpBxQX13bTglAZLYxGacpEdIjZnKsMtM
	QG8sqO4SOO9xKij9Hf8VNt/Sqaeh/oF5yqcpab7Qzs2UisOb6Zqn1Ljxy1W/yHRBSWnfRfHZB5K
	XwoLcA==
X-Google-Smtp-Source: AGHT+IFsoUNsZKjerOV56G4XYKfZyWvAntKSJGGhk3vCYo0YWbEwNmd5TjSqbsr3l2nPJ1TiKUWXTC0bT2qotuyukbQ=
X-Received: by 2002:a05:6512:230a:b0:594:750e:1f53 with SMTP id
 2adb3069b0e04-59576e13618mr100574e87.25.1762889231088; Tue, 11 Nov 2025
 11:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
In-Reply-To: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 11 Nov 2025 11:26:43 -0800
X-Gm-Features: AWmQ_bn4dxVx1lBNbH8PWoRfGDh1pL7JrgTYZHIYTl7d2EJCVBbNB8Ju5ASDoi4
Message-ID: <CALzav=cmkiFUjENpYk3TT7czAeoh8jzp4WX_+diERu7JhyGCpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:48=E2=80=AFAM Alex Mastro <amastro@fb.com> wrote=
:
>
> Changes in v3:
> - Update capability chain cycle detection
> - Clarify the iova=3Dvaddr commit message
> - Link to v2: https://lore.kernel.org/r/20251111-iova-ranges-v2-0-0fa267f=
f9b78@fb.com

All tests are still passing on v3 for me.

