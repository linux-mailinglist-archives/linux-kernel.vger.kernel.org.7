Return-Path: <linux-kernel+bounces-780088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FCBB2FD81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8DB64291D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945312E7F3F;
	Thu, 21 Aug 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE80OWAW"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE22DC322;
	Thu, 21 Aug 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787696; cv=none; b=ssrDbw/xc1rnnAeX27/5/E3xSS9sSSnEHJtdRzxeh6XxPI5SWSeM9DM7D4mMeCz5lhCXD+Tk1aQUh6zu/PfwVtCqVkjWkRFy+ZxOFzeR7+g0KaMoZ/j6C0rpWdJYewqVBk4yAbGPLP0XVwgnn/AAPFQbz2G+1+B1GXR+ubi4WCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787696; c=relaxed/simple;
	bh=r0EJ+QDYEK58wxXorFrnXARW0Dw1H+iE79HhQ7biUhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FR0ksZBwbxr3eph+NS7h8GLNWTIudxNyw+z0+J9xeH35uJPRtgkca+q0TATxtqMya6RyK9kfjEBhru46H/Kx4gNaBENKdkGzfhzQdViEytyZkNzgSsYrEb+ejAGAHbiipbukGw5zAz7VRw7QrADZJghU5Xb0pG1fPFSD1u7WXK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE80OWAW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244581eab34so2188515ad.2;
        Thu, 21 Aug 2025 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755787694; x=1756392494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reaan4HiyJD6kst2BoAhgABOgavP9PeNK2hSKp1XYMw=;
        b=iE80OWAWmCR9f38qLR8g3XvkcJ/PTML9UaH820S0GKggvArXztVurBEit00BEi+LH0
         K+y/l0wz1g3iEKLJcA6/nx8GdGQYdWZ4BoX4DVmVEiWsafW/ZJ6b3OwXjDCwWbQcwFfv
         SciQHqrPutD4zPyPKzb1ovxhlEzszL5OS0r2en7yHza+nk2qBwlC3wShVb9p7lVo4WNn
         E4C1oAAePkWJmX85ojOabC87rsinjB/mMdWSOQjmhrdQOUhvPayhgMqFPqPeF5M1SQaS
         Kzc7NwvfsllNnAOI7yZQLl6NcR91dSc6GTOGnGgRVCaIJjfH3bMR6i0GHT2kalwH8T3D
         9L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787694; x=1756392494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reaan4HiyJD6kst2BoAhgABOgavP9PeNK2hSKp1XYMw=;
        b=MFkfAGnUc3T6Gp0P3pLb/5MxXp/stOPAoPxtGPwP0RNr8f2Ve9RERlqEB1xBHb4CWD
         7b5rZ4Py4gSjJVJhIjFKQA56Ibm3XeB+AN1bqaR9Gzo4MFrIX5js1ogsYgYvv5K7XwoK
         UUXbPlctge36H99KxzbKg8EZMHBkB2O8g4EPpzhMAOBOSusXNfafwH8a2YhlZRrNH7aM
         61YPmRjqXhMfKge0smiJw/BY75WWAZOLMwZYbr47zNX+9eHK3oZiDHBwtamH/JxsFB0H
         Qd02+Sro3xJ/BQl5RmmWv6wtsG7ZjYmcSfSmeq9DmNx0r2rk9hGU/svQDacGLLEUAIaU
         UQeg==
X-Forwarded-Encrypted: i=1; AJvYcCVt7a3iLP5KkY130CJ3X51Y2TPy5CYOrQ2AzFVKaqiIgpp6eugkAvcQZ/uSUTuD16nCCZkwIrL1QjcUo4Y=@vger.kernel.org, AJvYcCXxFUu1R5eaG4mFC2SMB2vTEXL0Zx9Ns9S2zMyHrXb+/WcZWMEcIBVWzIqDI7lASlayODzKR4Mq9I/3HVhC3Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7E6NvQPWyxR3scsH/Sf4tfjVYddI7vjtIsQXCA227+7woOkQ/
	sNy7eq+LfvPajxg1XnyJ33kQ/Nqste00FRP4RHWAgh4dMAY2iVOYCaoKCfR3VrCvYLAoKnScFYs
	T5PxsYXDoWHo8Ov2NHxr8HUm8iwHMeC0=
X-Gm-Gg: ASbGncsnGlp8Yr6zUWmTqv/FcWdByN+Z/Evte6pkGQL1x2jE0qEAFQ3hgTPqLU9ATjS
	oUdEnRHAhlM9iWPhe9YNLRTS6wFXtBfW6ZM6bKV4nXCLCYZ6cnVSKrJ0geYJX2Qx07MHE5bbYKv
	uAK/pWw7wuZBfq2UyL3aVlGTlBO4DraW8W3/joBWo1cS+Ws9Y8LcLM9bgpkQH0WfqJHQxAm5rte
	KAz3d7iaA/qCxZWbt4=
X-Google-Smtp-Source: AGHT+IEsHKyQrAD63gSNI/LC3sifQUA4fe7CtQqeng2rumieUeyfruWmeT8Ilb+5Mz7ko+187xuq2c13SAz9CUXS664=
X-Received: by 2002:a17:903:2f85:b0:22e:62c3:8c5d with SMTP id
 d9443c01a7336-245ff8de159mr19322105ad.8.1755787693699; Thu, 21 Aug 2025
 07:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818135846.133722-1-ryasuoka@redhat.com> <20250818135846.133722-2-ryasuoka@redhat.com>
 <2025081836-unbraided-justness-4b43@gregkh> <aKQHQ4av5ZqfQ8Q1@zeus>
 <2025081935-railcar-playing-eb9d@gregkh> <aKSGW1SXcYleSdph@zeus>
In-Reply-To: <aKSGW1SXcYleSdph@zeus>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Aug 2025 16:48:02 +0200
X-Gm-Features: Ac12FXxBFYbLlcdpa2LM94AF4JEKXpd7rOoEG8zd-NmjQaAriUujV9krNAxe9zQ
Message-ID: <CANiq72m0DJ4jtc9c-2NusjXu96anVfu1LR5gGZAoyP12a5b-dA@mail.gmail.com>
Subject: Re: [PATCH rust-next 1/2] rust: miscdevice: add llseek support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, lee@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:12=E2=80=AFPM Ryosuke Yasuoka <ryasuoka@redhat.co=
m> wrote:
>
> Got it. I'll try to include an in-tree user for it next time.

Thanks! Yeah, please see:

    https://rust-for-linux.com/contributing#submitting-new-abstractions-and=
-modules

for some more context on the "in-tree user" rule and ideas on how to
possibly provide one.

I hope that helps.

Cheers,
Miguel

