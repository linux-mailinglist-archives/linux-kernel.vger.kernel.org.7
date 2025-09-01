Return-Path: <linux-kernel+bounces-794250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292ADB3DEFE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027B8167716
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10030C375;
	Mon,  1 Sep 2025 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="U5rCYei5"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B3303C9D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720123; cv=none; b=BBZTIK8V7ZUJFra2kuWQdWz6dVvLipfpEUMy8cD1oWuGjRrQZn1hs/A2oPRixKbTREECHCFsmp6FV/eGbw81g9evv9K+JwIxxohl4ucQoE+qgZYnCNH2Yj8RDohhGjNGoo09q1YS/4gy+s8C/A/VhUe532J+/DIHLs7D+uNYDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720123; c=relaxed/simple;
	bh=yAMzs5EIRVRAxslxMp63SpyhDGxPn/8lHQuJpXOa5Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=augHb8CXffyN2wx+hYMh9P3egsvdhXVhNQTY8r+C1xNYcOoy2RxZbhTNxCWsvEqH4jOTRNraLltLT2/OlWLiOgTU+6ns8a6iQaC0iC2v/I12jpcpbzugdVM5MX7gMlNdCB1iwv3g5mSOp8ZeBIU/XkLN0odTvXljAOoNrjhUi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=U5rCYei5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0225483ca0so284300966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756720120; x=1757324920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAMzs5EIRVRAxslxMp63SpyhDGxPn/8lHQuJpXOa5Os=;
        b=U5rCYei5DrNo4OaNtDIpURsPijDtG9n1fWqF862PLrkq7zbUOiaVAfVxRFeOyspX0D
         2KAqy/L4rFA55RH4Y2j4ETyO0xrUjvg/418jmoz3tH4s/BXmNURL3XhUpmt/kry6tWyT
         dQHp8SVB59N2ub05LT3yyIoLBMu9xfLk4qrL3MFwrxXHjU+rn4lHJzhs4AHKcEZgrdC1
         eMJxZJIydY5Cfxa9YlonK0ad+3+61ENnLf6vGwDs/UCbxsuzuh6XJ+7L+L51I6ijlEw3
         IEEPr7wTd0jQQVkZ+XsModD97wBczbfYXr0RzfE42kJ1HRFXfDanvz+FMjj8sgzyhP7B
         oohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720120; x=1757324920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAMzs5EIRVRAxslxMp63SpyhDGxPn/8lHQuJpXOa5Os=;
        b=pCv1ZRQE+JqlcYKyyiwv7S/9PmIzsibU8GMcrhw5OxWe2FLHdLYd0ynhV9MjQ2OxSd
         /DwmWHbwMeSTeEtlcoyCHRy+YYsmrTV3VCAQujF6YqlKjRcDoyw23zkyAt9TsV+8OTmY
         hLxAMtOFXinmV5+8bwQzgf3AVIHH+ME9uTRAcLHKFB4vS7+owfcwHKFXFebLhkk3EQzS
         yAX1YREU6UuJpc2iSUfJ1Sd6T+xLw18L8kBpeMVIlA9ON2t1dPQnfyLZeR7V/VywhEHT
         6MFrz/qG4DxsDMSIcmHThrLbJSOgMptysbw/yVjVADwWzdOl7LxoqvJXoLHdHeyuY950
         ayXw==
X-Forwarded-Encrypted: i=1; AJvYcCX5+FEK09dPHsHBd1pDh2TWAbL6bzropzo0j+Wf66yztURrwWUtqHCjyW7QZ2CmiMqSDJijbhZ+mamMyqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpE7Ag1w4QomugHBHLdiOK50vD/OK0xdwjXcDCjlG3qvCXRwq
	4CsKiuHl6JJrV8nt0gkncgj0TQfiz9yv1i1NsHnKq9cWTk0xY4N8f9RTTRNmk74rLqMoPeG0s7Y
	AVLnlaGONnJynbmp4NmUFjz4AtYQJ1dP9QkyoNSXwnw==
X-Gm-Gg: ASbGnct6FFm/quqXD0jkHpUNV5RQo7xvwDNWF+TppzVVyiGHXTYTdHop8N1dmAfJ5Rp
	Zt56ez/M4s3QasAVraarpQQ/hI65P5IrxRbcyMHyI8d8EQq9pqT2TkaTZDwN45B6vMikt+nn7pL
	8OwzBDDH5dr7Bu8n3pwDMJWENdZT8MZJC4+wX4E+Av30qIeNK464NQFShLI1H1E2gqbkNa6M4Pr
	t33S50feRROAo9CEzRZHPF3HYSZ1rDJqy4=
X-Google-Smtp-Source: AGHT+IF9uPPihIpLNdOWfEOntV654qtMzSCsbA0hQdbcxVqqaSFVavOEVOieLFuxIRfTzmWFGI2O5TYxf4HiGmb1Fzc=
X-Received: by 2002:a17:907:7e82:b0:afe:ec09:2a23 with SMTP id
 a640c23a62f3a-b01d9769f7fmr622348566b.43.1756720119900; Mon, 01 Sep 2025
 02:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com> <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com> <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com> <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
 <661e6140-572b-4480-9ca2-6a127730f32b@redhat.com>
In-Reply-To: <661e6140-572b-4480-9ca2-6a127730f32b@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 11:48:27 +0200
X-Gm-Features: Ac12FXzz8zeQxpYSNEubBaIfkFsD7okOqxhasIrHBExuNTUi_qYL4d0rCVeU-Og
Message-ID: <CAKPOu+_KbBRdtB-WiZuiva7Fqsus4x7zBOPkqdhwfYFkdS-doA@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer parameters
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org, 
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:41=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
> There is an important distinction between garbage and a reasonable patch
> description.

It's still not clear to me where you draw the line (it's opinion, no
objective truth; to me, every redundant piece of text is effectively
garbage because it steals my time) - but you asked me to get busy
instead of arguing with you.

