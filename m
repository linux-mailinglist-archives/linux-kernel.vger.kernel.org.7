Return-Path: <linux-kernel+bounces-893068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F4C46771
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CC71881C85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ADC309EF2;
	Mon, 10 Nov 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRo1jBDN"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D03090D5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776264; cv=none; b=SGW5YAIN0NYNkB87Jli/bYgszgVCCY4cbrQaJpNzEjfE70tiSM2kopSRaX82hhCtpEB5MuYHCvIgC7E4O2LrnbSJZH3JozKpNjLqeguU2m6aVguyIOzwJPdhB7r+xa9rEzwnbw2mrvnQ3lyisNje3xlBmtqDtHT57E83qGT0xAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776264; c=relaxed/simple;
	bh=eEgXHGzlAYOJl5c6fOfboUSe/VxaQBrlFhhrVppwDjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/Spr1kSVBgXKlrDwGPuBQYGFSgK1FVL59V6/kQspGaLJOhnojqpK3Md95tY+l76UDpVIGIuJmbKbqgrEUwNFZklJD8CyVgyL+CC+65t8OxD3Nagbh8Q+9IBwqF5Ap4LHw7it2K3wCGcsjjIZjfOn63ZcN8qgdZH6cU9GDDMeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRo1jBDN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b9da0ae5763so225354a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762776261; x=1763381061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEgXHGzlAYOJl5c6fOfboUSe/VxaQBrlFhhrVppwDjc=;
        b=fRo1jBDNOiODeONp2SpTugjWLgOK/efWMsHQLlQHcC39kP7+sh9HhPLPj8/JizonyG
         7b+QCsSt3zqOWPgd+pwpn+79kM+Tr8XpShLgFpvK9sMrxUKcafSB+bvJWIr0APKJPJg7
         FfGmp6mGdLDLVVDc/3CMatGQRzDhuP14hfaMDLh5eXTBTTKJpB2tfGfVMO8UGhsboMd8
         0wN66lqOn9Lx8RL+khOb2Xs2xWJs92R3N/wyljDcWri9FjTgglb3XYeu1hzEG0LGrpMO
         WNintcuhk3OKBHp6Bk8NmnCMaSr7/2x9d0tZpj+cQfVkCU+sDg1w2CE8Gmq4SmTzGKUa
         fZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776261; x=1763381061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eEgXHGzlAYOJl5c6fOfboUSe/VxaQBrlFhhrVppwDjc=;
        b=m4gfu4j5ESj+Y1KTjrz+HvUEr23cRdEgahO+ihWSQwre5lFN8O5DIc2xW/Py0Dvc/C
         OO7dKGMzEtNuS3gOM2/XRAXSECpKDl1aRBQSm+3Gvd2CQlN6p0SbfjqMA5ETKEkWQ50Y
         ejKtZxLiV1qtc8JGGEsRmbUjcs2pxOjCMRqGY9ubqEiTIhe6qfUWit/N8V0CJuv2krEJ
         /kGv5Q99fixz32T+sTrYK91oKepTI51U5vQHIb8raE62N46sCjpS6cPp7avlDrlBojDq
         4CXdd5VcAOZWgF7RN6IPh7SXDtKEafIGDEQwVq9tC2tQ19P99zy5RzdNy4Wp71zGZ95o
         pAlw==
X-Forwarded-Encrypted: i=1; AJvYcCVV258OtYrHsW0d3uRD6U20AuKJltU2F7c0Hec53BIAooZIrPghI7qhuSlpQjOqqtwuHktlDjvzqQJFCrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/pU4+O/kjHI6+IBagUI05L4DmMiPQiu8IaqnQVv3kFQyFGRO
	quUdwuUZixUnuHIjfKguq/knT41a0DpU239loTRcySuU7hGBhx9bF+JEO39c9L2+jPBCY8NgOId
	t2ThZFzaM7ycQNkmOC7jbSZLofS7PXco=
X-Gm-Gg: ASbGncsT4FIze6dJOqFO0KbQWhM9zR/34C58Eniy+IQz60EZT9w2lwyt7J9QyyoE8GH
	MYgE/pRxKqHaFswHiIktSQ7W6aI/7j2pnKmQeIZd1P7eclLcujQybGK2kJaz1sw0GYY4Ctw17aI
	YAyVW4BLWWox4eZl+fAvXH7cbeTvTDgLn48ynVBqTwVFhSMnnTUZHbQV17wj5/DOL5b4eYaaoR0
	QYeQw35q9A1hN67T4yv73HquKEFgkSjbJmx6Cm2mG7ncxH74bKcBijNRdbjmUAZcWJas6ZN0/Yo
	nuPYP8n6yeF996kR6ihWAZyhhw/AUESjCbjsepGTwKa495+wYQ1qm9zWDpTYr2V+8lf17o+RmD6
	aSEM90FhPRm+Bkg==
X-Google-Smtp-Source: AGHT+IExnxjKRMhBvCvd9Nw1Vzpg0dilgRX0ilaQeygPAtmrJ/VO92XIw2N3ZJ7sb6hS/zOwLVLxlgfmv0VAGSAIzy8=
X-Received: by 2002:a17:903:230f:b0:295:70b1:edd6 with SMTP id
 d9443c01a7336-297e5643e76mr52737955ad.3.1762776260815; Mon, 10 Nov 2025
 04:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110113528.1658238-1-ojeda@kernel.org> <aRHSLChi5HYXW4-9@google.com>
In-Reply-To: <aRHSLChi5HYXW4-9@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 13:04:08 +0100
X-Gm-Features: AWmQ_bklNKkIpzDaIt0BmvJnv6iHBReLEFoejSD6lCAMShx-lppQSbZzdpW8AeA
Message-ID: <CANiq72n29SUnmm3Dos_NvWbxW-vuX2Y2j7AAYROpa6ruQWguSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:53=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Maybe we should also allow disallowed_names in doc tests?

Not sure -- I thought it may point people to try to come up with
better names in examples. On the other hand, for abstract facilities,
it is true that there may not be good names anyway.

Cheers,
Miguel

