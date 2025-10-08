Return-Path: <linux-kernel+bounces-845778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF8BC6157
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E3564EB507
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5742EC548;
	Wed,  8 Oct 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5glQCaI"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740DD261B70
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942440; cv=none; b=bTcsdRivwY0yY2ZVIBAXD2LbBz2iY1dfP9//zOPzqbA14aWXhpl5d15vmdGYYUi71q6las0h2exrE1qvrKjOfUWOLhraWx3ltZsxnwD1hADjwIXDMgz7TBh/Ud7Mer+KFwS3sKguu4ksEp6QLntKGr0YkDL+yqPZB8DZhm/n49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942440; c=relaxed/simple;
	bh=jsdDoDNG7qC8k729T1BbWctZo4QpNIT4HRQNrvjqvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMBQg9eWfz8B+aI9VZD+dp06ituBa03QATUYCm8eg456HLbOu+70g856+pqMZQ5CKE+jki+lE2Ba4E3FJ5NxEVcBg4dFdVFktQTAhLhOMj8ngvS8UNb+I/bt+29OE9nTx6kcE2RmVB4xlhdRgeYX43SM8PkPbhldqTaoIKWWsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5glQCaI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2731ff54949so665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759942438; x=1760547238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc8rX32dX1hioJjgjcjbwMHUmlxFF9DAwOuIRqiY3NI=;
        b=o5glQCaIdrHkqojsewGGYLZh1dteZYOGnDa4ht1p7xaxqPL8esl4Jnuiqojo+udsRP
         742JeqpVmC8cElZh2R70vxh2tAL/gDWIknOfsRaFdXwmeq91XSoVd7F5PE3YWRoT6/Xp
         JtdOsrJzdiCUgBqdQ3SHN/koNhQO3mbZD/pAcAKV7DdGn5o/UFSIGgvUCwpTqdb2NqkC
         LZJstY77hKQYy+dR7vIvpFl+csIIeKMtxxQJZ/VS/DLVNCTQTCMgOCyCiA4BR4/hHg9V
         FQolQcsI2RRARD5qRbi6Ji9oINY8AzAVoccP9v5dzY02pnYf7bqkssdZDlTyCZJOevZs
         +JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942438; x=1760547238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc8rX32dX1hioJjgjcjbwMHUmlxFF9DAwOuIRqiY3NI=;
        b=VDe9lpXwVdkrZ973Z+ZvqJta7KTs8k/o9AH5OUbZaZDm9Ha1bitQMVukxxKlNFPH1q
         86gZ05R9emN6rOmfTSOfCweyxlx4ncXsdvrg38LnMORa4+rpEaD7rJHrwoqpSCcYt/VT
         JmyLMFSZZo9CLlYJczDzcXt1k281Zq2TcNcgaLdT86u5L8KJXue+n9Z+t1/1vUeoMHGX
         J1qXHftk+eOD1u0M5JLGV6W9+gu+tczssozCnXXmZFCJ2w0AmZNni16UcwqesXijvYwH
         EJfXTDyuldl+/iS1VqEqxj//5aPc6R2C1Y6oZDtKI5hikK344uH/h/ooNOuv8+MCyM1n
         Kj5A==
X-Forwarded-Encrypted: i=1; AJvYcCUDRMWysMbVU+NZBn1cVynVUkUdQ5aWvkuDnRrd5IwhkjThnZNSh0BOGw4NmMyL+HFiO1Ge7Q7xQnf6yy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGivtV/2s8wwTU1DkaHStrXuxNn2KPoOUBUoG5b0kHVMfO8U1U
	h/nerA/XsC396BFglesqyW2ZP9z08McorlszYUvxteLbomzM5gPrjQ68qzN3Y4AoXg==
X-Gm-Gg: ASbGncuOUidzi6zBm/22XG2m6g3kf1vyxkMt/YRmW8Ku6axGSDQxe+uB228A3Qdy+h8
	lLtbYLoZ1TWtOLBI21dtqOwOwac5/fXocm6stBZO4hidivmKXcOESBTFrj0AUVsX7KEq+l121kQ
	9Q7E10EYC0EkOnt8sGawd++Ptwt8lsCTH7zTYfzBHr1dTf+zwqOmINpX2b+Phq242Z6XOWzus+S
	YpjfXammVYEdPRtwZQ4XigjommOSeMZx3VgDsIYNyXplcncMZ65uElgWtjh7GYix1svCtXU/uzM
	Bfu+FDZa+PiZAS0KohR6ipU10TNh4+h7fpRsIM9skO1D0sLfIV/FbBoE45OKftHzSTFklTe6/QE
	oa9VIYPCN2JxQOtGZ203kBu+FqQUi56bPt5f5cr2sKQ1s3gGN3qTqWcBg6AOLSVkQ0Zsz7eOw2J
	JdsRlg9uu9NUSLO4q9fU7p/WI71ZRfcMc9zRHbhXBGxom7bVJBlm/AyQjczQRWzn5NKlu4/HQyC
	A==
X-Google-Smtp-Source: AGHT+IFfNNZZ1N5hdA2Rzgdeu2MiPYlEFl4C9y1hCCjIX5eMBd16YLU0grlSCxevOHzpz/NXmGwdCQ==
X-Received: by 2002:a17:902:d4d0:b0:265:e66:6c10 with SMTP id d9443c01a7336-290275dda96mr7152475ad.4.1759942437279;
        Wed, 08 Oct 2025 09:53:57 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034dea083sm2487245ad.24.2025.10.08.09.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:53:56 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:53:52 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust_binder: don't delete FreezeListener if there
 are pending duplicates
Message-ID: <aOaXIHS6YapFWytL@google.com>
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
 <20251007-binder-freeze-v2-2-5376bd64fb59@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-binder-freeze-v2-2-5376bd64fb59@google.com>

On Tue, Oct 07, 2025 at 09:39:52AM +0000, Alice Ryhl wrote:
> When userspace issues commands to a freeze listener, it identifies it
> using a cookie. Normally this cookie uniquely identifies a freeze
> listener, but when userspace clears a listener with the intent of
> deleting it, it's allowed to "regret" clearing it and create a new
> freeze listener for the same node using the same cookie. (IMO this was
> an API mistake, but userspace relies on it.)
> 
> Currently if the active freeze listener gets fully deleted while there
> are still pending duplicates, then the code incorrectly deletes the
> pending duplicates too. To fix this, do not delete the entry if there
> are still pending duplicates.
> 
> Since the current data structure requires a main freeze listener, we
> convert one pending duplicate into the primary listener in this
> scenario.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/binder/freeze.rs | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
> index 74bebb8d4d9b24860eed34363ce69b1c6df58028..e304aceca7f31c15444cf67bb13488cd144345e6 100644
> --- a/drivers/android/binder/freeze.rs
> +++ b/drivers/android/binder/freeze.rs
> @@ -106,7 +106,16 @@ fn do_work(
>              return Ok(true);
>          }
>          if freeze.is_clearing {
> -            _removed_listener = freeze_entry.remove_node();
> +            kernel::warn_on!(freeze.num_cleared_duplicates != 0);
> +            if freeze.num_pending_duplicates > 0 {
> +                // The primary freeze listener was deleted, so convert a pending duplicate back
> +                // into the primary one.
> +                freeze.num_pending_duplicates -= 1;
> +                freeze.is_pending = true;
> +                freeze.is_clearing = true;
> +            } else {
> +                _removed_listener = freeze_entry.remove_node();
> +            }
>              drop(node_refs);
>              writer.write_code(BR_CLEAR_FREEZE_NOTIFICATION_DONE)?;
>              writer.write_payload(&self.cookie.0)?;
> 
> -- 
> 2.51.0.618.g983fd99d29-goog
> 

Acked-by: Carlos Llamas <cmllamas@google.com>

