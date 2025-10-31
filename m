Return-Path: <linux-kernel+bounces-879768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88BC23FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C364564BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6BE32D7D6;
	Fri, 31 Oct 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNI5ipt5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3126FDA5;
	Fri, 31 Oct 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901241; cv=none; b=VNE53wQ2rx/YdBQx7gbGPQtRhUbmbQ44Jbdr8AV4tYZ3OrA0yRRZXzFmfjuGROMywnPbtU0oONe22gvJnTKr8/K9xPNemZprxN7na+lxWL6EsOr3nSkGeDQ7tCTZ839bpyfHjG6PDIhegmPIexvvDcPtRA4kOgRa/NUIxonwV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901241; c=relaxed/simple;
	bh=cI2iZAW8PV/PB8lHMkN53VOykrZcBJpPojzOoAR2Tp0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JxCIYUVDH2DOGD+HCvR89B1IrFYEQwCRVrIflEhq6WXtUBQGH5IIBv5+paFBkf7DoWUy/epGNRtyLzh8iiyg1SMTiEmwyXYEvQnXNlb9cmRjBEXiJw3ecb57oxvY+xttiKEVjRA/QwQwh2m1pWiSLNLa/lC4kqWgSp4GkjhmDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNI5ipt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB109C4CEF1;
	Fri, 31 Oct 2025 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761901241;
	bh=cI2iZAW8PV/PB8lHMkN53VOykrZcBJpPojzOoAR2Tp0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TNI5ipt5yJ+hG0iB57xLqCsi4FQ9Si5Tdwi/cginDvNUPf9+svSh0W+wfdVBO+Ju5
	 uRukp9QhhoGh4DCPeTpPtbk1G1HnDpAYHEV1xOg3qc73GNAlXlrw61RqGf3TuRRh0c
	 K7uHNY4PNXaFjAV4Yx1PerWItzgCQj/Ai+Fc2hJzUavEij8gZJ044imbntKrnl2T+K
	 Vt+vMXFJ+VOtbRE37EtmHMtK0aUbIWMia5J8z2rhG78sGa9v+EenYYsUHMUp6HJoLW
	 LpQM+xjUs4umFiwjlpkvS5fiqmiPYM5Vqb8NgJ/jrivjmHqgpc9QMl+9AvMZymWyEX
	 LSyQfuwWpLL1g==
Date: Fri, 31 Oct 2025 10:00:38 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Siarhei Vishniakou <svv@google.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Roderick Colenbrander <roderick.colenbrander@sony.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: playstation: Remap joystick axes to be centered at
 0
In-Reply-To: <20251010012006.2282321-1-svv@google.com>
Message-ID: <no3r172s-899p-7s78-o199-8q8oq1r2nr71@xreary.bet>
References: <20251010012006.2282321-1-svv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Oct 2025, Siarhei Vishniakou wrote:

> The joystick axes (ABS_X, ABS_Y, ABS_RX, ABS_RY) for PlayStation
> gamepads report a neutral state of 128 over HID, with a full range of
> [0, 255]. The driver previously mapped this directly, resulting in an
> evdev range of [0, 255] with a resting point of 128.
> 
> This approach is unconventional for Linux gamepad drivers and has several
> drawbacks: it requires userspace applications to be aware of the
> non-zero resting state, and it is incompatible with the input
> subsystem's 'flat' (deadzone) logic, which assumes a resting point of 0.
> 
> This patch remaps the four joystick axes to the conventional signed
> 8-bit range of [-128, 127], with 0 as the neutral state. This is
> accomplished by changing their evdev range in ps_gamepad_create() and
> translating the incoming hardware value in the report parsing functions
> by subtracting 128.
> 
> The analog trigger axes (ABS_Z, ABS_RZ) are handled separately. Their
> resting state is 0 (un-pressed), and their hardware range of [0, 255]
> is already the conventional representation. They are left unmodified by
> this patch.
> 
> This makes the joystick behavior consistent with other gamepad drivers
> while preserving the standard behavior for the triggers.
> 
> Signed-off-by: Siarhei Vishniakou <svv@google.com>

Hmmm ... as I am rather unaware of the existing playstation userspace 
ecosystem -- is there any way how we could now be breaking existing 
playstation-specific userspace assumptions that have already developed 
based on asumptions that we're centered at 128?

Thanks,

-- 
Jiri Kosina
SUSE Labs


