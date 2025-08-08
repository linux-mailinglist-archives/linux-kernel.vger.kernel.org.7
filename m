Return-Path: <linux-kernel+bounces-759887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B3CB1E3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607D13A7F09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F123F40A;
	Fri,  8 Aug 2025 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZx9NoVF"
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA84AEE2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754640120; cv=none; b=r6kWW2WVylDAtrkq19WbEHLwgvCfcRpcJCA37NQGjVLjufIf1odFRnBYN14ByzpFuW53hKVR+yZZLUZy5UiJP8mE5DoqVacBYUnv0sIzcYTRrWyMYolrknUKxFQynrIygn/eTqxXi1+vtUbkEd0sT6tZpiUxgqRP1XpS6iOVi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754640120; c=relaxed/simple;
	bh=7oyJJ3eAXJRwGcVTY8F95qK1JKOI+/WBg933hpV9mrc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uoWK2486QBHw7VyFw4XQdSiqC60UOtucZYt27HgA6F7OA3tVB4KUFa/UplSCMcDiSdE42sBiCS+pvWaB1fGsX8qAAq+IaUbLx3ldcaKI2ZDa0m0iL6eW8c2woU7puoD4MjOulP0/uhiEVU9RsPD1/7zDBO9xG+aya/RCxm0x0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZx9NoVF; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e8da1fd7b6bso1675610276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754640118; x=1755244918; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MWJMHho/a9SJWI4X4vVnP0p90321hImD1R14P1yKy40=;
        b=WZx9NoVFIX/tYcwPFB5dulWjSxmNYnQu6hfCA3nGwEypltg+s6VVgjNIzZUSTC0p3y
         o10ohrzosLsJI8JEB+tGS2XrMBTUJqGn30JFXIyg88dVvgeKsqGpKam3Kncibof0tkgj
         Y0vB0B9gpSOAQsEdDO8H5F822N51zgeiK2twAIEO06rfaxJRPpY/hzdlngzWFxY1+i/K
         1DBTI5mIZIthKl9myDcQAJ9GAlRmMuEmLtFziGzJacfzy3zJUrbYyVu/kam8KTjK5xod
         cwuQ+nBJC5vKXj//cSd/WKvZ1i6XVjMsIcv4xv7Dspmp8aZj4ySS6PDVXtza7COVaJj3
         MBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754640118; x=1755244918;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWJMHho/a9SJWI4X4vVnP0p90321hImD1R14P1yKy40=;
        b=UiTnXvNMYkEbM+QGGgm8djyIGMMQGr4mojsaX2hg5SNWiR6C4g3jDcleesxtHFO96J
         GhDJBGSsZFNqpb1PCHHPwpl2bYww4tapktjgK4EyOvgXPjnQBxOyydB3W96UX4AQxFt7
         /acVBv/p7OtEFOXiyI35gaHhLjDAtDpcdZYUm5ChFrndG/JYZZfjNs8lRP7WipuJZehr
         IH3WH9zBFLZaSVWgUkNA2gpWzfrywz/4Apxsxk7sKOqbDH42yA2WdGIC9wtesCaGUqf8
         Eq/dVbfaslevycvPus294+cKhpZO0anKwoRZMTt5CyX/44PMdhnpuhLQoItYnumJWcwj
         lzwg==
X-Gm-Message-State: AOJu0Yw0PGFQm0lTm651QEucROcjIypSO+rBG4DmLqU2ry1sCF/K9TVO
	afUQatwQcwJZqmke4r4ZjS1yn4mSFFhDhqzFy4DXDSjFhqa+PvmPD3CFYxSr6VM5dbHvB85ejMG
	BERfluGzkDiVSEtp/a1BBPZOsIthiIr+2i7uWgC4=
X-Gm-Gg: ASbGnctaRIORujgFzpdvJkQIo05OC3jbw4a2e11QYKLWWTnPhZkuJDhBUEew7wzJ7Lt
	+mE8gCDhiV8jsTASvUG09X5v5Yr7p6NAoWz2ZvI620OhSziQgajr+l87u5D/tYj7P8D2Z5WNbNM
	Gsngj5itI1+ees/POSpMjz8aape1hg4Tx2HZF7zwSBEtK9Q3xOEo28OjdSk2gdtv9Wmtp/DZN5E
	OnchrvZ2IAUH82lU71W9rIEoZhiwdgiexystkjawDKLwwe4NHs2
X-Google-Smtp-Source: AGHT+IE73fjllbl+mmjrUZeCbrVPwf0Dz0AIssUI9Fpy4fJnW2YQVOXCqQCYTjzYXk8xyyhfO2RGqjqH1mMYmnuExOs=
X-Received: by 2002:a05:690c:8685:10b0:71b:f4b7:181b with SMTP id
 00721157ae682-71bf4b725dcmr9136197b3.34.1754640117764; Fri, 08 Aug 2025
 01:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Fri, 8 Aug 2025 13:31:46 +0530
X-Gm-Features: Ac12FXzJL-tOkPc7YE3pa3weAVrS_OLBQw85H7ZXJqrK1n-X19Rfl2jygbcIHwI
Message-ID: <CAFf+5ziTOmMxKky9T+hb=zjWdD2OfLpS2s7FEn81r4tT-tG2gA@mail.gmail.com>
Subject: List of string functions that are not present in the standard C library.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

------------------------------------------------------------------------
List of string functions that are not present in the standard C library.
------------------------------------------------------------------------

** Many of the following functions take an argument (int case_insensitive) for
   doing either case-sensitive or case-insensitive op.

* get_input_from_stdin_and_discard_extra_characters()
* discard_all_characters_from_stdin()

* is_str_ascii()
* is_str_spaces_only()
* is_str_whitespaces_only()
* is_str_integer()
* is_str_long()
* is_str_float()
* is_str_double()

* str_regex_match()

* str_split()
* str_split_regex()
* str_join()
* substr()
* substr_regex()

* str_trim_leading_spaces()
* str_trim_leading_whitespaces()
* str_trim_trailing_spaces()
* str_trim_trailing_whitespaces()
* str_trim_spaces()
* str_trim_whitespaces()

* convert_num_to_usa_format()

* compare_chars_case_insensitive()

* str_starts_with()
* str_starts_with_regex()
* str_ends_with()
* str_ends_with_regex()

* str_replace_char_first_match()
* str_replace_char_last_match()
* str_replace_char_all()
* str_replace_str_first_match()
* str_replace_str_last_match()
* str_replace_str_all()
* str_replace_regex_first_match()
* str_replace_regex_last_match()
* str_replace_regex_all()

* str_delete_char_first_match()
* str_delete_char_last_match()
* str_delete_char_all()
* str_delete_str_first_match()
* str_delete_str_last_match()
* str_delete_str_all()
* str_delete_regex_first_match()
* str_delete_regex_last_match()
* str_delete_regex_all()

* str_insert_char()
* str_insert_str()

* str_compare_range()
* str_replace_range()
* str_delete_range()

* str_left_pad_char()
* str_right_pad_char()

* get_random_char()
* get_random_char_in_range()
* get_random_str()
* get_random_str_in_range()

* str_sort_ascending()
* str_sort_descending()

* convert_str_to_lowercase()
* convert_str_to_uppercase()

* condense_consecutive_spaces()
* condense_consecutive_whitespaces()
* capitalize_first_char()

* str_hash_code()

* strtok_dm() // dm means don't modify string

----

