Return-Path: <linux-kernel+bounces-804536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B173B4792E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 07:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5D4189F693
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 05:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9691DF26A;
	Sun,  7 Sep 2025 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMc2pS+A"
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC61D6DDD
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757222923; cv=none; b=iUru1U8LTCN0sl7t4zXi3TbNWCD6k0is+pzFd0Go2RJj7U9Ngt/rcy217TRoCTThelzBWuk/bFW1mJqKOz6JP8UxWcsR9ZvMAdMsZ9NVbsYyLb46Z6x7ikngCcx/36LL9LtDxAEjq5VDR9wlLShzm23qOa54cpx3Y7RM+y3myPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757222923; c=relaxed/simple;
	bh=xQyQ2Y5Hu656OvyczSDQSBHWFNtwTuBpqyCZbazGmkQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=d1lRWnJL8ovsyxDidPKilF6p/LwsrlDA37d162voKTO1nCc9JyZjGi5a0wIdGiwKO3C6rtJ3YJiiYLgssMhE3AeHMHjS9kiEM0JcimQUJ9OtJnw45ZqIMMpfzWDwpwrRDlN9y6TLkWZf/Uwv0stS6nYo44YhOx1z6FieIh0BXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMc2pS+A; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-61381743635so84545d50.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 22:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757222920; x=1757827720; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dbSxjK5BcmN9UBzwtXQzTdSB39/pf8VcvycNulW3lZ0=;
        b=AMc2pS+AO0a+IVPONjsT3b6W+C3XXvBO4Yh7nNASF9RGO5xTVmR1Nz1fFxLnMtWUbG
         6v+iPu1L/yQ3N9OevqlgL77E7kVC/UNoWWsy1yzwvV/V+3CJDyZ3U+aY92BxnvaYmYDS
         J/UwGLjDnFQTsBmTbctxpHczrA84CGpyl+OSzTZ/5UHthqB6F18CcqBXXWNrkmcTwD+8
         VXLdhslsIA8FLFsOsUvKU39I2NYt8Ausp7eZmbDXIY2iVt63VLwZnXbW7bzeH4XYQLNw
         dz432f4OljU+j4S8b9hENCaWFnvJAwUBsM6pE7SjgACZfd1te95H/7M0JNh+5oW+EMZW
         /Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757222920; x=1757827720;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbSxjK5BcmN9UBzwtXQzTdSB39/pf8VcvycNulW3lZ0=;
        b=a9NLGj9KT1nGmbv0VfKQwVgy0K0RqHXpQbc9zd9t0/7z0mXwS0g1LcVesVGiGjO8RF
         G29xWhMFOfX9IfMBs1C8PcY6IvaAb9yhvBfyrwHN1O6fAlHmzUjd8Rnm+ISsCciiZQGX
         di1GnfS4b9a2Q8d5UCTprl5ptEUwy15A4sWCalAcdTWtWPMlMHO23ZtV+ztEz/VJwFCL
         +baEzxGfBFYvtm7AjkxVN0STEhyeZTdCGov5poGuJBPCI+9Zr2/Nn+9Anu5EY33U3u4m
         DFVtMdCdUkAfx+bQiFFNNZa2qc1XCLCk/pfH5pEJ3qznlgOYDnT/wuksq5TNsFwVKuAr
         Ppfw==
X-Gm-Message-State: AOJu0YxsPAi3q2k/2KkpwhkcSW2o7sGQhPpOQ65FLGIkmVX2HTN9/VTQ
	1pJHnTD+AKgQ0qtsDUflrXIvd9D0wwk8o/7RnD/nujzd8bodTa1zLZqodoJ54j5W3KNYxOZFwTU
	BTLeHWOO/RM5j3mQzOLrc36DloMrCUzKahq9QeV0=
X-Gm-Gg: ASbGncuajz7c3oV/8EHOqJK0nHxuO28bRfnp8MiISsmxJxY4bW8mF/ijgO1ohoGLwlf
	J0rA5XEvPJmzma1+xUzU2jcnZBwhCnI1sZdoSi3KeKU8RFqWi2tPjN/ywWSKBQ4pan9z/hGubWI
	6YMo2QXtDncPSPdfL1XqkPFxzJpsHphIkh3Q/QacqPwdxXueCF9iSvjY+TRA4zcldHn2SXgCtwh
	7jyTXz9OLN+1z+EObUYh07SPm5Cvj/TY5+3oP2cBHckyHofTaQ=
X-Google-Smtp-Source: AGHT+IFbJyKJY4WxHAm7qLbzf4JJclSzNT35ZQbq/TcKs0L7hVEpk57blmGgMCFtAdm0SJ1jNkiWk1v9da2VdYnNUq0=
X-Received: by 2002:a05:690e:431c:b0:5fd:45a3:fe29 with SMTP id
 956f58d0204a3-61028bc2d5emr2512189d50.24.1757222919576; Sat, 06 Sep 2025
 22:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Sun, 7 Sep 2025 10:58:28 +0530
X-Gm-Features: Ac12FXxQVdjsTTocH8upiHZeQfFh5l6ubJUtDh32wi9h7N13NKyTxSdE-0gRa_I
Message-ID: <CAFf+5zjE4f6N1-WXxwygWLxzKDs_6Ptfd2Grv7xtd90NNGyF4A@mail.gmail.com>
Subject: Generic quicksort library (Six files: generic_quicksort_library.c,
 generic_quicksort_library.h, test_generic_quicksort_library.c,
 compile_all.sh, run_test_generic_quicksort_library.sh, and ReadMe.txt).
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Generic quicksort library (Six files: generic_quicksort_library.c,
generic_quicksort_library.h, test_generic_quicksort_library.c, compile_all.sh,
run_test_generic_quicksort_library.sh, and ReadMe.txt).

----------------------------
generic_quicksort_library.c
----------------------------

/*
 * License:
 *
 * This file has been released under "unlicense" license
 * (https://unlicense.org).
 *
 * This is free and unencumbered software released into the public domain.
 *
 * Anyone is free to copy, modify, publish, use, compile, sell, or distribute
 * this software, either in source code form or as a compiled binary, for any
 * purpose, commercial or non-commercial, and by any means.
 *
 * For more information about this license, please visit - https://unlicense.org
 */

/*
 * Author: Amit Choudhary
 * Email: amitchoudhary0523 AT gmail DOT com
 */

#include "generic_quicksort_library.h"

#include <stdio.h>

const char *convert_error_num_to_error_string(int error_num)
{

    if (error_num == GQL_COMPARE_ELEMENTS_FUNCTION_PTR_IS_NULL) {
        return ("The function pointer given for comparing the elements is"
                " NULL.");
    } else if (error_num == GQL_SWAP_ELEMENTS_FUNCTION_PTR_IS_NULL) {
        return ("The function pointer given for swapping the elements is"
                " NULL.");
    }

    return ("Invalid error number given.");

} // end of function convert_error_num_to_error_string()

int generic_quicksort_ascending(void *array_ptr, int id,
                                long start_index, long end_index,
                                compare_elements_function_ptr comp_func,
                                swap_elements_function_ptr swap_func)
{

    long pivot_index = -1;
    long forward_ptr_index = start_index;
    long backward_ptr_index = end_index - 1;
    int retval = -1;

    if (!comp_func) {
        return GQL_COMPARE_ELEMENTS_FUNCTION_PTR_IS_NULL;
    }

    if (!swap_func) {
        return GQL_SWAP_ELEMENTS_FUNCTION_PTR_IS_NULL;
    }

    if ((start_index < 0) || (end_index < 0)) {
        return GQL_SUCCESS;
    }

    if (start_index >= end_index) {
        return GQL_SUCCESS;
    }

    if ((end_index - start_index) == 1) { // two elements
        if (comp_func(array_ptr, id, start_index, end_index) > 0) {
            swap_func(array_ptr, id, start_index, end_index);
        }
        return GQL_SUCCESS;
    }

    pivot_index = (start_index + end_index)/2;

    swap_func(array_ptr, id, pivot_index, end_index);

    while (1) {

        while (comp_func(array_ptr, id, forward_ptr_index, end_index) <= 0) {
            forward_ptr_index = forward_ptr_index + 1;
            if (forward_ptr_index == end_index) {
                break;
            }
        }

        while (comp_func(array_ptr, id, backward_ptr_index, end_index) >= 0) {
            backward_ptr_index = backward_ptr_index - 1;
            if (backward_ptr_index == (start_index - 1)) {
                break;
            }
        }

        if (forward_ptr_index < backward_ptr_index) {
            swap_func(array_ptr, id, forward_ptr_index, backward_ptr_index);
            forward_ptr_index = forward_ptr_index + 1;
            backward_ptr_index = backward_ptr_index - 1;
            continue;
        } else if (forward_ptr_index > backward_ptr_index) {
            // If forward_ptr_index is equal to the end_index then all the
            // elements from start_index till (end_index - 1) are smaller than
            // the element at the end_index.
            if (forward_ptr_index == end_index) {
                retval = generic_quicksort_ascending(array_ptr, id, start_index,
                                                     end_index - 1, comp_func,
                                                     swap_func);
                if (retval != GQL_SUCCESS) {
                    return retval;
                }
            } else { // forward_ptr_index is less than the end_index
                swap_func(array_ptr, id, forward_ptr_index, end_index);
                retval = generic_quicksort_ascending(array_ptr, id, start_index,
                                                     forward_ptr_index - 1,
                                                     comp_func, swap_func);
                if (retval != GQL_SUCCESS) {
                    return retval;
                }
                retval = generic_quicksort_ascending(array_ptr, id,
                                                     forward_ptr_index + 1,
                                                     end_index, comp_func,
                                                     swap_func);
                if (retval != GQL_SUCCESS) {
                    return retval;
                }
            }
        } else {
            // At this point, forward_ptr_index is equal to the
            // backward_ptr_index. But this should not happen. This means that
            // there is/are some bug(s) in this library. So, we will print an
            // error message on 'stderr' and then crash this library so that the
            // program using this library also crashes and a core dump is
            // generated for debugging.
            fprintf(stderr, "There is/are some bug(s) in this library (%s)"
                    " because forward_ptr_index (%ld) is equal to the"
                    " backward_ptr_index (%ld) and this should not happen."
                    " Crashing this library so that the program using this"
                    " library also crashes and a core dump is generated for"
                    " debugging.\n", __FILE__, forward_ptr_index,
                    backward_ptr_index);

            // The following line of code will crash this library.
            (*((char *)(-1))) = 1;
        }

        return GQL_SUCCESS;

    } // end of while (1) loop

    // Code execution will not reach here.
    return GQL_SUCCESS;

} // end of function generic_quicksort_ascending()

int generic_quicksort_descending(void *array_ptr, int id,
                                 long start_index, long end_index,
                                 compare_elements_function_ptr comp_func,
                                 swap_elements_function_ptr swap_func)
{

    long pivot_index = -1;
    long forward_ptr_index = start_index;
    long backward_ptr_index = end_index - 1;
    int retval = -1;

    if (!comp_func) {
        return GQL_COMPARE_ELEMENTS_FUNCTION_PTR_IS_NULL;
    }

    if (!swap_func) {
        return GQL_SWAP_ELEMENTS_FUNCTION_PTR_IS_NULL;
    }

    if ((start_index < 0) || (end_index < 0)) {
        return GQL_SUCCESS;
    }

    if (start_index >= end_index) {
        return GQL_SUCCESS;
    }

    if ((end_index - start_index) == 1) { // two elements
        if (comp_func(array_ptr, id, start_index, end_index) < 0) {
            swap_func(array_ptr, id, start_index, end_index);
        }
        return GQL_SUCCESS;
    }

    pivot_index = (start_index + end_index)/2;

    swap_func(array_ptr, id, pivot_index, end_index);

    while (1) {

        while (comp_func(array_ptr, id, forward_ptr_index, end_index) >= 0) {
            forward_ptr_index = forward_ptr_index + 1;
            if (forward_ptr_index == end_index) {
                break;
            }
        }

        while (comp_func(array_ptr, id, backward_ptr_index, end_index) <= 0) {
            backward_ptr_index = backward_ptr_index - 1;
            if (backward_ptr_index == (start_index - 1)) {
                break;
            }
        }

        if (forward_ptr_index < backward_ptr_index) {
            swap_func(array_ptr, id, forward_ptr_index, backward_ptr_index);
            forward_ptr_index = forward_ptr_index + 1;
            backward_ptr_index = backward_ptr_index - 1;
            continue;
        } else if (forward_ptr_index > backward_ptr_index) {
            // If forward_ptr_index is equal to the end_index then all the
            // elements from start_index till (end_index - 1) are smaller than
            // the element at the end_index.
            if (forward_ptr_index == end_index) {
                retval = generic_quicksort_descending(array_ptr, id,
                                                      start_index,
                                                      end_index - 1, comp_func,
                                                      swap_func);
                if (retval != GQL_SUCCESS) {
                    return retval;
                }
            } else { // forward_ptr_index is less than the end_index
                swap_func(array_ptr, id, forward_ptr_index, end_index);
                retval = generic_quicksort_descending(array_ptr, id,
                                                      start_index,
                                                      forward_ptr_index - 1,
                                                      comp_func, swap_func);
                if (retval != GQL_SUCCESS) {
                    return retval;
                }
                retval = generic_quicksort_descending(array_ptr, id,
                                                      forward_ptr_index + 1,
                                                      end_index, comp_func,
                                                      swap_func);
                if (retval != GQL_SUCCESS) {
                    return retval;
                }
            }
        } else {
            // At this point, forward_ptr_index is equal to the
            // backward_ptr_index. But this should not happen. This means that
            // there is/are some bug(s) in this library. So, we will print an
            // error message on 'stderr' and then crash this library so that the
            // program using this library also crashes and a core dump is
            // generated for debugging.
            fprintf(stderr, "There is/are some bug(s) in this library (%s)"
                    " because forward_ptr_index (%ld) is equal to the"
                    " backward_ptr_index (%ld) and this should not happen."
                    " Crashing this library so that the program using this"
                    " library also crashes and a core dump is generated for"
                    " debugging.\n", __FILE__, forward_ptr_index,
                    backward_ptr_index);

            // The following line of code will crash this library.
            (*((char *)(-1))) = 1;
        }

        return GQL_SUCCESS;

    } // end of while (1) loop

    // Code execution will not reach here.
    return GQL_SUCCESS;

} // end of function generic_quicksort_descending()

----------------------------
generic_quicksort_library.h
----------------------------

/*
 * License:
 *
 * This file has been released under "unlicense" license
 * (https://unlicense.org).
 *
 * This is free and unencumbered software released into the public domain.
 *
 * Anyone is free to copy, modify, publish, use, compile, sell, or distribute
 * this software, either in source code form or as a compiled binary, for any
 * purpose, commercial or non-commercial, and by any means.
 *
 * For more information about this license, please visit - https://unlicense.org
 */

/*
 * Author: Amit Choudhary
 * Email: amitchoudhary0523 AT gmail DOT com
 */

#ifndef _GENERIC_QUICKSORT_LIBRARY_H_
#define _GENERIC_QUICKSORT_LIBRARY_H_


// GQL/gql means generic quicksort library.


// Success and error macros are defined below.

// Everything happened successfully.
#define GQL_SUCCESS 0

// The function pointer given by the user for comparing the elements is NULL.
#define GQL_COMPARE_ELEMENTS_FUNCTION_PTR_IS_NULL -1

// The function pointer given by the user for swapping the elements is NULL.
#define GQL_SWAP_ELEMENTS_FUNCTION_PTR_IS_NULL -2

// This value is used only for initializing error variables.
#define GQL_ERROR_INIT_VALUE -100


/*
 * The user needs to give the function pointer of a function that will compare
 * the elements of the array.
 *
 * This function will get four arguments - 'array_ptr', 'id, 'first_index' and
 * 'second_index'. The 'first_index' and the 'second_index' will be the indices
 * of the array.
 *
 * The return value of this function should be a negative integer if the element
 * at the 'first_index' is less than the element at the 'second_index', 0 (zero)
 * if the element at the 'first_index' is equal to the element at the
 * 'second_index', and a positive integer if the element at the 'first_index' is
 * greater than the element at the 'second_index'.
 *
 * If the elements of 'array_ptr' are strings (char *), then the user should
 * handle NULL values and empty strings also.
 *
 * If the elements of 'array_ptr' are pointers (but not strings), then the user
 * should handle NULL values also.
 */
typedef int (*compare_elements_function_ptr)(void *array_ptr, int id,
                                             long first_index,
                                             long second_index);

/*
 * The user needs to give the function pointer of a function that will swap the
 * elements of the array.
 *
 * This function will get four arguments - 'array_ptr', 'id, 'first_index' and
 * 'second_index'. The 'first_index' and the 'second_index' will be the indices
 * of the array.
 *
 * The user has to swap the elements at 'first_index' and 'second_index'.
 */
typedef void (*swap_elements_function_ptr)(void *array_ptr, int id,
                                          long first_index,
                                          long second_index);

const char *convert_error_num_to_error_string(int error_num);

/*
 * generic_quicksort_ascending():
 *
 * The function generic_quicksort_ascending() will sort an array in ascending
 * order and the data type of the elements of the array can be anything, like -
 * int, long, char *, struct key_value *, etc. So, this function is independent
 * of the data type of the elements of the array and this function achieves this
 * by taking the function pointers for comparing the elements of the array and
 * for swapping the elements of the array from the "caller of this function".
 *
 * Arguments:
 *
 *      array_ptr: This is the pointer to the array that the user wants to sort.
 *                 This function will send 'array_ptr' back as an argument to
 *                 the compare elements function and to the swap elements
 *                 function so that the user doesn't have to make the array
 *                 global for accessing it in the compare elements / swap
 *                 elements functions.
 *
 *      id:        This argument 'id' is necessary if the user has only one
 *                 compare elements function and only one swap elements function
 *                 and the user wants to sort more than one array and the data
 *                 types of the elements of these arrays are different - for
 *                 example - one array has integer elements, another array has
 *                 string elements, etc. So, in these two functions, the user
 *                 will have to know the data type of the elements of
 *                 'array_ptr' so that the user can do the right thing. So, for
 *                 this, 'id' is required. The user will send the 'id' as an
 *                 argument to this function and this function will send this
 *                 'id' back to the compare elements / swap elements functions
 *                 so that the user can identify the data type of the elements
 *                 of 'array_ptr' and do the right thing. So, the user can send
 *                 the 'id' as 1 for integer data type, 2 for long, 3 for
 *                 string, 4 for a user defined structure, etc.
 *
 *      start_index: This is the index of 'array_ptr' from where the user wants
 *                   to start sorting the array. In general, this will be
 *                   0 (zero).
 *
 *      end_index: This is the index of 'array_ptr' till which the user wants to
 *                 sort the array. In general, this will be the last index of
 *                 'array_ptr' (number_of_elements_in_array_ptr - 1).
 *
 *      comp_func: This is the function pointer of the function that will
 *                 compare the elements of 'array_ptr'.
 *
 *                 This function will get four arguments - 'array_ptr', 'id,
 *                 'first_index' and 'second_index'. The 'first_index' and the
 *                 'second_index' will be the indices of 'array_ptr'.
 *
 *                 The return value of this function should be a negative
 *                 integer if the element at the 'first_index' is less than the
 *                 element at the 'second_index', 0 (zero) if the element at the
 *                 'first_index' is equal to the element at the 'second_index',
 *                 and a positive integer if the element at the 'first_index' is
 *                 greater than the element at the 'second_index'.
 *
 *      swap_func: This is the function pointer of the function that will
 *                 swap the elements of 'array_ptr'.
 *
 *                 This function will get four arguments - 'array_ptr', 'id,
 *                 'first_index' and 'second_index'. The 'first_index' and the
 *                 'second_index' will be the indices of 'array_ptr'.
 *
 *                 The user has to swap the elements at 'first_index' and
 *                 'second_index'.
 */
int generic_quicksort_ascending(void *array_ptr, int id,
                                long start_index, long end_index,
                                compare_elements_function_ptr comp_func,
                                swap_elements_function_ptr swap_func);
/*
 * generic_quicksort_descending():
 *
 * The function generic_quicksort_descending() will sort an array in descending
 * order.
 *
 * The rest of the details for this function are the same as for the function
 * generic_quicksort_ascending(). Please look above for the details of the
 * function generic_quicksort_ascending().
 */

int generic_quicksort_descending(void *array_ptr, int id,
                                 long start_index, long end_index,
                                 compare_elements_function_ptr comp_func,
                                 swap_elements_function_ptr swap_func);
#endif

---------------------------------
test_generic_quicksort_library.c
---------------------------------

/*
 * License:
 *
 * This file has been released under "unlicense" license
 * (https://unlicense.org).
 *
 * This is free and unencumbered software released into the public domain.
 *
 * Anyone is free to copy, modify, publish, use, compile, sell, or distribute
 * this software, either in source code form or as a compiled binary, for any
 * purpose, commercial or non-commercial, and by any means.
 *
 * For more information about this license, please visit - https://unlicense.org
 */

/*
 * Author: Amit Choudhary
 * Email: amitchoudhary0523 AT gmail DOT com
 */

#include "generic_quicksort_library.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define NUM_ARRAY_ELEMENTS 100L
#define MAX_INT_VALUE_ALLOWED 10000

#define TRUE 1
#define FALSE 2

#define ASC 3 // ascending order
#define DESC 4 // descending order

#define INTEGER 5
#define STRING 6

#define MAX_STR_SIZE 3 // including null terminating character

#define ARRAY_IS_NOT_SORTED -1000

// Function prototypes for gcc flag -Werror-implicit-function-declaration.
int compare_elements(void *array_ptr, int id, long first_index,
                     long second_index);
void swap_elements(void *array_ptr, int id, long first_index,
                   long second_index);
void discard_all_characters_from_stdin(void);
void wait_for_user_to_press_enter(void);
int get_wait_for_user_option_value(int argc, char *argv[]);
char *get_random_alphabetical_string(int len);
void free_strings_of_array(char **array_ptr);
int test_if_array_is_sorted(void *array_ptr, int id, int sorting_order);
void print_array(void *array_ptr, int id);
void sort_array_of_integers(int sorting_order);
void sort_array_of_strings(int sorting_order);

// Read and discard all characters from stdin until '\n' or EOF is received.
void discard_all_characters_from_stdin(void)
{

    int c = 0;

    // discard all characters from stdin
    while ((c = getchar()) && (c != '\n') && (c != EOF));

    return;

} // end of function discard_all_characters_from_stdin()

void wait_for_user_to_press_enter(void)
{

    printf("Please press \"ENTER\" key to continue..");

    discard_all_characters_from_stdin();

    return;

} // end of function wait_for_user_to_press_enter()

int compare_elements(void *array_ptr, int id, long first_index,
                     long second_index)
{

    if (!array_ptr) {
        printf("\nError: %s(): Argument 'array_ptr' is NULL. Some bug(s) in"
               " generic quicksort library. Exiting..\n", __FUNCTION__);
        exit(EXIT_FAILURE);
    }

    if ((first_index < 0) || (first_index >= NUM_ARRAY_ELEMENTS)) {
        printf("\nError: %s(): Argument 'first_index' (%ld) is out of bounds"
               " (0 - %ld). Some bug(s) in generic quicksort library."
               " Exiting..\n", __FUNCTION__, first_index, NUM_ARRAY_ELEMENTS);
        exit(EXIT_FAILURE);
    }

    if ((second_index < 0) || (second_index >= NUM_ARRAY_ELEMENTS)) {
        printf("\nError: %s(): Argument 'second_index' (%ld) is out of bounds"
               " (0 - %ld). Some bug(s) in generic quicksort library."
               " Exiting..\n", __FUNCTION__, second_index, NUM_ARRAY_ELEMENTS);
        exit(EXIT_FAILURE);
    }

    if (id == INTEGER) {
        int *arr_ptr = (int *)(array_ptr);
        if (arr_ptr[first_index] > arr_ptr[second_index]) {
            return 1;
        } else if (arr_ptr[first_index] < arr_ptr[second_index]) {
            return -1;
        } else {
            return 0;
        }
    } else if (id == STRING) {
        char **arr_ptr = (char **)(array_ptr);
        char *first_string = arr_ptr[first_index];
        char *second_string = arr_ptr[second_index];
        if ((first_string == NULL) && (second_string == NULL)) {
            return 0;
        } else if (first_string == NULL) {
            return -1;
        } else if (second_string == NULL) {
            return 1;
        }
        return (strncmp(first_string, second_string, MAX_STR_SIZE));
    }

    // Got invalid 'id'.
    printf("\nError: %s(): Argument 'id' (%d) is invalid. Some bug(s) in"
           " generic quicksort library. Exiting..\n", __FUNCTION__, id);
    exit(EXIT_FAILURE);

} // end of function compare_elements()

void swap_elements(void *array_ptr, int id, long first_index, long second_index)
{

    if (!array_ptr) {
        printf("\nError: %s(): Argument 'array_ptr' is NULL. Some bug(s) in"
               " generic quicksort library. Exiting..\n", __FUNCTION__);
        exit(EXIT_FAILURE);
    }

    if ((first_index < 0) || (first_index >= NUM_ARRAY_ELEMENTS)) {
        printf("\nError: %s(): Argument 'first_index' (%ld) is out of bounds"
               " (0 - %ld). Some bug(s) in generic quicksort library."
               " Exiting..\n", __FUNCTION__, first_index, NUM_ARRAY_ELEMENTS);
        exit(EXIT_FAILURE);
    }

    if ((second_index < 0) || (second_index >= NUM_ARRAY_ELEMENTS)) {
        printf("\nError: %s(): Argument 'second_index' (%ld) is out of bounds"
               " (0 - %ld). Some bug(s) in generic quicksort library."
               " Exiting..\n", __FUNCTION__, second_index, NUM_ARRAY_ELEMENTS);
        exit(EXIT_FAILURE);
    }

    if (id == INTEGER) {
        int *arr_ptr = (int *)(array_ptr);
        int temp = arr_ptr[first_index];
        arr_ptr[first_index] = arr_ptr[second_index];
        arr_ptr[second_index] = temp;
        return;
    } else if (id == STRING) {
        char **arr_ptr = (char **)(array_ptr);
        char *temp = arr_ptr[first_index];
        arr_ptr[first_index] = arr_ptr[second_index];
        arr_ptr[second_index] = temp;
        return;
    }

    // Got invalid 'id'.
    printf("\nError: %s(): Argument 'id' (%d) is invalid. Some bug(s) in"
           " generic quicksort library. Exiting..\n", __FUNCTION__, id);
    exit(EXIT_FAILURE);

} // end of function swap_elements()

int test_if_array_is_sorted(void *array_ptr, int id, int sorting_order)
{

    long i = 0;
    long last_index = NUM_ARRAY_ELEMENTS - 1;

    if (!array_ptr) {
        printf("\nError: %s(): Argument 'array_ptr' is NULL. Exiting..\n",
               __FUNCTION__);
        exit(EXIT_FAILURE);
    }

    if ((sorting_order != ASC) && (sorting_order != DESC)) {
        printf("\nError: %s(): Argument 'sorting_order' (%d) is neither"
               " ascending (%d) nor descending (%d). Exiting..\n", __FUNCTION__,
               sorting_order, ASC, DESC);
        exit(EXIT_FAILURE);
    }

    if (id == INTEGER) {

        int *arr_ptr = (int *)(array_ptr);

        if (sorting_order == ASC) {
            for (i = 0; i < last_index; i++) {
                if (arr_ptr[i] > arr_ptr[i + 1]) {
                    return ARRAY_IS_NOT_SORTED;
                }
            } // end of for loop
            return GQL_SUCCESS;
        } else { // descending order
            for (i = 0; i < last_index; i++) {
                if (arr_ptr[i] < arr_ptr[i + 1]) {
                    return ARRAY_IS_NOT_SORTED;
                }
            } // end of for loop
            return GQL_SUCCESS;
        }

    } else if (id == STRING) {

        char **arr_ptr = (char **)(array_ptr);

        if (sorting_order == ASC) {
            for (i = 0; i < last_index; i++) {
                if (strncmp((arr_ptr[i] ? arr_ptr[i] : ""),
                            (arr_ptr[i+1] ? arr_ptr[i+1] : ""),
                            MAX_STR_SIZE) > 0) {
                    return ARRAY_IS_NOT_SORTED;
                }
            } // end of for loop
            return GQL_SUCCESS;
        } else { // descending order
            for (i = 0; i < last_index; i++) {
                if (strncmp((arr_ptr[i] ? arr_ptr[i] : ""),
                            (arr_ptr[i+1] ? arr_ptr[i+1] : ""),
                            MAX_STR_SIZE) < 0) {
                    return ARRAY_IS_NOT_SORTED;
                }
            } // end of for loop
            return GQL_SUCCESS;
        }

    } // end of if-else id == INTEGER or STRING

    // Got invalid 'id'.
    printf("\nError: %s(): Argument 'id' (%d) is invalid. Some bug(s) in"
           " generic quicksort library. Exiting..\n", __FUNCTION__, id);
    exit(EXIT_FAILURE);

} // end of function test_if_array_is_sorted()

void print_array(void *array_ptr, int id)
{

    long i = 0;

    if (!array_ptr) {
        printf("\nError: %s(): Argument 'array_ptr' is NULL. Exiting..\n",
               __FUNCTION__);
        exit(EXIT_FAILURE);
    }

    if (id == INTEGER) {
        int *arr_ptr = (int *)(array_ptr);
        printf("\n");
        for (i = 0; i < NUM_ARRAY_ELEMENTS; i++) {
            printf("%d%s", arr_ptr[i],
            ((i != (NUM_ARRAY_ELEMENTS -1)) ? ", " : "."));
        }
        printf("\n");
        return;
    } else if (id == STRING) {
        char **arr_ptr = (char **)(array_ptr);
        printf("\n");
        for (i = 0; i < NUM_ARRAY_ELEMENTS; i++) {
            printf("%s%s", arr_ptr[i],
            ((i != (NUM_ARRAY_ELEMENTS -1)) ? ", " : "."));
        }
        printf("\n");
        return;
    }

    // Got invalid 'id'.
    printf("\nError: %s(): Argument 'id' (%d) is invalid. Some bug(s) in"
           " generic quicksort library. Exiting..\n", __FUNCTION__, id);
    exit(EXIT_FAILURE);

} // end of function print_array()

void sort_array_of_integers(int sorting_order)
{

    int arr[NUM_ARRAY_ELEMENTS];
    int retval = GQL_ERROR_INIT_VALUE;
    char *asc = "ascending";
    char *desc = "descending";
    long i = 0;

    if ((sorting_order != ASC) && (sorting_order != DESC)) {
        printf("\nError: %s(): Argument 'sorting_order' (%d) is neither"
               " ascending (%d) nor descending (%d). Exiting..\n", __FUNCTION__,
               sorting_order, ASC, DESC);
        exit(EXIT_FAILURE);
    }

    srand((unsigned int)(time(NULL)));

    for (i = 0; i < NUM_ARRAY_ELEMENTS; i++) {
        arr[i] = rand() % (MAX_INT_VALUE_ALLOWED + 1);
    }

    printf("\n");
    printf("===================================================\n");
    printf("Sorting an array of integers in \"%s\" order.\n",
           ((sorting_order == ASC) ? asc : desc));
    printf("===================================================\n");

    if (sorting_order == ASC) {
        retval = generic_quicksort_ascending(arr, INTEGER, 0,
                                             NUM_ARRAY_ELEMENTS - 1,
                                             compare_elements, swap_elements);
    } else { // descending order
        retval = generic_quicksort_descending(arr, INTEGER, 0,
                                              NUM_ARRAY_ELEMENTS - 1,
                                              compare_elements, swap_elements);
    }

    if (retval != GQL_SUCCESS) {
        printf("\nError: %s(): [Error number: %d]. The array of integers was"
               " not sorted successfully. Some bug(s) in generic quicksort"
               " library. Exiting..\n", __FUNCTION__, retval);
        exit(EXIT_FAILURE);
    }

    retval = test_if_array_is_sorted(arr, INTEGER, sorting_order);

    if (retval != GQL_SUCCESS) {
        printf("\nError: %s(): [Error number: %d]. The array of integers was"
               " not sorted successfully. Some bug(s) in generic quicksort"
               " library. Exiting..\n", __FUNCTION__, retval);
        exit(EXIT_FAILURE);
    }

    printf("\nThe array of integers was sorted successfully in \"%s\" order.\n",
           ((sorting_order == ASC) ? asc : desc));

    printf("\nPrinting the sorted array of integers:\n");

    print_array(arr, INTEGER);

    printf("\n");

    return;

} // end of function sort_array_of_integers()

char *get_random_alphabetical_string(int len)
{

    char *str = NULL;
    int i = 0;

    if ((len < 0) || (len > (MAX_STR_SIZE - 1))) {
        return NULL;
    }

    str = calloc((size_t)(len+1), 1); // extra 1 for null terminating character

    if (!str) {
        printf("\nError: %s(): No memory available. Exiting..\n", __FUNCTION__);
        exit(EXIT_FAILURE);
    }

    for (i = 0; i < len; i++) {
        str[i] = (char)('a' + (rand() % 26));
    }

    str[i] = 0;

    return str;

} // end of function get_random_alphabetical_string()

void free_strings_of_array(char **array_ptr)
{

    long i = 0;

    if (!array_ptr) {
        return;
    }

    for (i = 0; i < NUM_ARRAY_ELEMENTS; i++) {
        free(array_ptr[i]);
        array_ptr[i] = NULL;
    }

    return;

} // end of function free_strings_of_array()

void sort_array_of_strings(int sorting_order)
{

    char *arr[NUM_ARRAY_ELEMENTS];
    int retval = GQL_ERROR_INIT_VALUE;
    char *asc = "ascending";
    char *desc = "descending";
    long i = 0;

    if ((sorting_order != ASC) && (sorting_order != DESC)) {
        printf("\nError: %s(): Argument 'sorting_order' (%d) is neither"
               " ascending (%d) nor descending (%d). Exiting..\n", __FUNCTION__,
               sorting_order, ASC, DESC);
        exit(EXIT_FAILURE);
    }

    srand((unsigned int)(time(NULL)));

    for (i = 0; i < NUM_ARRAY_ELEMENTS; i++) {
        if ((i % 40) == 0) {
            arr[i] = get_random_alphabetical_string(0);
        } else if ((i % 20) == 0) {
            arr[i] = get_random_alphabetical_string(MAX_STR_SIZE * 2);
        } else {
            arr[i] = get_random_alphabetical_string(MAX_STR_SIZE - 1);
        }
    } // end of for loop

    printf("\n");
    printf("==================================================\n");
    printf("Sorting an array of strings in \"%s\" order.\n",
           ((sorting_order == ASC) ? asc : desc));
    printf("==================================================\n");

    if (sorting_order == ASC) {
        retval = generic_quicksort_ascending(arr, STRING, 0,
                                             NUM_ARRAY_ELEMENTS - 1,
                                             compare_elements, swap_elements);
    } else { // descending order
        retval = generic_quicksort_descending(arr, STRING, 0,
                                              NUM_ARRAY_ELEMENTS - 1,
                                              compare_elements, swap_elements);
    }

    if (retval != GQL_SUCCESS) {
        printf("\nError: %s(): [Error number: %d]. The array of strings was"
               " not sorted successfully. Some bug(s) in generic quicksort"
               " library. Exiting..\n", __FUNCTION__, retval);
        exit(EXIT_FAILURE);
    }

    retval = test_if_array_is_sorted(arr, STRING, sorting_order);

    if (retval != GQL_SUCCESS) {
        printf("\nError: %s(): [Error number: %d]. The array of strings was"
               " not sorted successfully. Some bug(s) in generic quicksort"
               " library. Exiting..\n", __FUNCTION__, retval);
        exit(EXIT_FAILURE);
    }

    printf("\nThe array of strings was sorted successfully in \"%s\" order.\n",
           ((sorting_order == ASC) ? asc : desc));

    printf("\nPrinting the sorted array of strings:\n");

    print_array(arr, STRING);

    printf("\n");

    free_strings_of_array(arr);

    return;

} // end of function sort_array_of_strings()

int get_wait_for_user_option_value(int argc, char *argv[])
{

    int wait_for_user = TRUE;

    if ((argc >= 2) && (strcmp(argv[1], "--no-wait") == 0)) {
        wait_for_user = FALSE;
    }

    return wait_for_user;

} // end of function get_wait_for_user_option_value()

int main(int argc, char *argv[])
{

    int wait_for_user = TRUE;

    wait_for_user = get_wait_for_user_option_value(argc, argv);

    // sort array of integers in ascending order
    sort_array_of_integers(ASC);

    if (wait_for_user == TRUE) {
        wait_for_user_to_press_enter();
    }

    // sort array of strings in ascending order
    sort_array_of_strings(ASC);

    if (wait_for_user == TRUE) {
        wait_for_user_to_press_enter();
    }

    // sort array of integers in descending order
    sort_array_of_integers(DESC);

    if (wait_for_user == TRUE) {
        wait_for_user_to_press_enter();
    }

    // sort array of strings in descending order
    sort_array_of_strings(DESC);

    exit(EXIT_SUCCESS);

} // end of function main()

---------------
compile_all.sh
---------------

#!/bin/bash

set -x

rm -f generic_quicksort_library.o

rm -f test_generic_quicksort_library.out

gcc -c -Wall -Werror -Wextra -Wundef -Wunreachable-code -Winit-self
-Wparentheses -Wconversion -Wsign-conversion -Wsign-compare
-Werror-implicit-function-declaration -Wmissing-prototypes
-Wmissing-declarations -Wformat-security generic_quicksort_library.c
-o generic_quicksort_library.o

if [ "$?" -ne "0" ]; then
    exit;
fi

rm -f generic_quicksort_library.o

gcc -Wall -Werror -Wextra -Wundef -Wunreachable-code -Winit-self
-Wparentheses -Wconversion -Wsign-conversion -Wsign-compare
-Werror-implicit-function-declaration -Wmissing-prototypes
-Wmissing-declarations -Wformat-security generic_quicksort_library.c
test_generic_quicksort_library.c -o test_generic_quicksort_library.out

--------------------------------------
run_test_generic_quicksort_library.sh
--------------------------------------

#!/bin/bash

count=0
retval=1

while true
do
    count=$((count+1))
    ./test_generic_quicksort_library.out --no-wait
    retval=$?
    echo
    set -x
    if [ "$retval" -ne "0" ]; then
        echo
        echo "test_generic_quicksort_library.out returned error."
        echo
        exit;
    fi
    set +x
    echo
    echo "---- `date \"+%Y-%m-%d-%H-%M-%S\"`, count = $count ----"
    echo
    sleep 1
done

-----------
ReadMe.txt
-----------

File "generic_quicksort_library.c" implements two generic quicksort functions.
These functions are - generic_quicksort_ascending() and
generic_quicksort_descending().

generic_quicksort_ascending() sorts an array in ascending order and
generic_quicksort_descending() sorts an array in descending order.

These functions can sort an array having any data type - int, long, char *,
struct key_value *, etc. These functions achieve this by taking the function
pointers for comparing the elements of the array and for swapping the elements
of the array from the "caller of these functions". Because of this, the two
functions of the generic quicksort library don't need to know what is the data
type of the elements of the array.

File "test_generic_quicksort_library.c" implements code to test the
generic_quicksort_ascending() and generic_quicksort_descending() functions.

There is also a bash shell script (run_test_generic_quicksort_library.sh) for
running the program (test_generic_quicksort_library.out) endlessly in a loop but
you probably don't need this.

---- End of ReadMe ----

